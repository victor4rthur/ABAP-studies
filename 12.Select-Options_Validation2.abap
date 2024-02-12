*&---------------------------------------------------------------------*
*& Report z_ad_aula9_2
*&---------------------------------------------------------------------*
*& VALIDAÇÃO Select-options - Caso alguma entrada não exista, será
*& apresentado a mensagem de erro.
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_2.

TABLES: ekko,
        mara.

DATA: v_erro TYPE c.                            "Variável para indicar erros
DATA: t_mara_valid  TYPE TABLE OF mara.         "Tabela criada para validação dos dados
DATA: wa_mara_valid TYPE mara.                  "Work área para ser usada em conjuto com a tabela acima

CONSTANTS: c_x TYPE c VALUE 'X'.                "Constante com o valor de X

SELECT-OPTIONS: s_matnr FOR mara-matnr.

CHECK v_erro IS INITIAL.
*-----------------------------------------------------------------------------*
* Início do programa
*-----------------------------------------------------------------------------*

PERFORM f_valida_dados .

*-----------------------------------------------------------------------------*
* Só continua o processamento se não foi encontrado nenhum erro nas validações
*-----------------------------------------------------------------------------*
CHECK v_erro IS INITIAL.

FORM f_valida_dados .

IF s_matnr[] IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE t_mara_valid
    WHERE matnr IN s_matnr. "Verifica se todos os dados podem não ser válidos

*--------------------------------------------------------------------*
* Se nenhum dado informado foi encontrado, então apresentar mensagem de erro
*--------------------------------------------------------------------*
  IF sy-subrc NE 0.
    MESSAGE text-001 TYPE 'S' DISPLAY LIKE 'E'. "Dados informados não encontrados na tabela de Materiais".
    v_erro = c_x.
  ENDIF.
ENDIF.

DATA: wa_s_matnr TYPE s_matnr.

LOOP AT s_matnr.
*--------------------------------------------------------------------*
* Será explicado com mais detalhes durante o vídeo esse tipo de execução
*--------------------------------------------------------------------*
  READ TABLE t_mara_valid into wa_mara_valid WITH KEY matnr = s_matnr-low.

  IF sy-subrc NE 0.
    MESSAGE e368(00) WITH text-001 s_matnr-low.
  ENDIF.

ENDLOOP.

ENDFORM.