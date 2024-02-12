*&---------------------------------------------------------------------*
*& Report z_ad_aula9_2
*&---------------------------------------------------------------------*
*& VALIDA��O Select-options - Caso alguma entrada n�o exista, ser�
*& apresentado a mensagem de erro.
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_2.

TABLES: ekko,
        mara.

DATA: v_erro TYPE c.                            "Vari�vel para indicar erros
DATA: t_mara_valid  TYPE TABLE OF mara.         "Tabela criada para valida��o dos dados
DATA: wa_mara_valid TYPE mara.                  "Work �rea para ser usada em conjuto com a tabela acima

CONSTANTS: c_x TYPE c VALUE 'X'.                "Constante com o valor de X

SELECT-OPTIONS: s_matnr FOR mara-matnr.

CHECK v_erro IS INITIAL.
*-----------------------------------------------------------------------------*
* In�cio do programa
*-----------------------------------------------------------------------------*

PERFORM f_valida_dados .

*-----------------------------------------------------------------------------*
* S� continua o processamento se n�o foi encontrado nenhum erro nas valida��es
*-----------------------------------------------------------------------------*
CHECK v_erro IS INITIAL.

FORM f_valida_dados .

IF s_matnr[] IS NOT INITIAL.
  SELECT *
    FROM mara
    INTO TABLE t_mara_valid
    WHERE matnr IN s_matnr. "Verifica se todos os dados podem n�o ser v�lidos

*--------------------------------------------------------------------*
* Se nenhum dado informado foi encontrado, ent�o apresentar mensagem de erro
*--------------------------------------------------------------------*
  IF sy-subrc NE 0.
    MESSAGE text-001 TYPE 'S' DISPLAY LIKE 'E'. "Dados informados n�o encontrados na tabela de Materiais".
    v_erro = c_x.
  ENDIF.
ENDIF.

DATA: wa_s_matnr TYPE s_matnr.

LOOP AT s_matnr.
*--------------------------------------------------------------------*
* Ser� explicado com mais detalhes durante o v�deo esse tipo de execu��o
*--------------------------------------------------------------------*
  READ TABLE t_mara_valid into wa_mara_valid WITH KEY matnr = s_matnr-low.

  IF sy-subrc NE 0.
    MESSAGE e368(00) WITH text-001 s_matnr-low.
  ENDIF.

ENDLOOP.

ENDFORM.