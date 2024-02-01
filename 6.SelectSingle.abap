*&---------------------------------------------------------------------*
*& Report Z_AD_AULA6_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula6_4.

*" Tipos
TYPES: BEGIN OF ty_saida,
         matnr TYPE mara-matnr,
         maktx TYPE makt-maktx,
       END OF ty_saida.

" Work Area
DATA: wa_mara  TYPE mara,
      wa_makt  TYPE makt,
      wa_saida TYPE ty_saida.

"Tela de seleção
PARAMETERS: p_matnr TYPE mara-matnr.

START-OF-SELECTION.
  "Seleção de dados
  SELECT SINGLE * "Seleciona todas as colunas da mara e coloca na wa_mara
         FROM mara
         INTO wa_mara "Dados de seleçao baseados na tela
         WHERE matnr EQ p_matnr. "A chave desta tabela é a própria matnr

  IF sy-subrc EQ 0.
    SELECT SINGLE * "Seleciona todas as colunas da makt e coloca na wa_mara
            FROM makt
            INTO wa_makt
            WHERE matnr EQ p_matnr AND spras = 'PT'. "A chave da tabela é o campo que retorna apenas uma linha.

    IF sy-subrc EQ 0.
      wa_saida-matnr = wa_mara-matnr. "O campo matnr da Wa_saida recebe o campo matnr da wa_mara.
      wa_saida-maktx = wa_makt-maktx.

      WRITE: wa_saida-matnr,
             wa_saida-maktx.
    ENDIF.
  ENDIF.