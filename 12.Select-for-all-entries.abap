*&---------------------------------------------------------------------*
*& Report z_ad_aula9_9
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_9.

TYPES: BEGIN OF ty_saida,
     matnr TYPE mara-matnr,
     mtart TYPE mara-mtart,
     maktx TYPE makt-maktx,
       END OF ty_saida.

TYPES: BEGIN OF ty_mara,
     matnr TYPE mara-matnr,
     mtart TYPE mara-mtart,
       END OF ty_mara.

TYPES: BEGIN OF ty_makt,
     matnr TYPE makt-matnr,
     maktx TYPE makt-maktx,
       END OF ty_makt.

DATA: t_saida  TYPE TABLE OF ty_saida,
      wa_saida TYPE ty_saida,
      t_mara  TYPE TABLE OF ty_mara,
      wa_mara TYPE ty_mara,
      t_makt  TYPE TABLE OF ty_makt,
      wa_makt TYPE ty_makt.

PARAMETERS: p_matnr TYPE mara-matnr.
*--------------------------------------------------------------------*
* Seleção dos dados da tabela de referência
*--------------------------------------------------------------------*
SELECT matnr mtart
  FROM mara
  INTO TABLE t_mara
  WHERE matnr EQ p_matnr.
*--------------------------------------------------------------------*
* Continuar para a segunda seleção apenas se encontrar dados na primeira
*--------------------------------------------------------------------*
IF sy-subrc EQ 0.
*--------------------------------------------------------------------*
* Selecionar dados da tabela secundária com base na tabela de referência
*--------------------------------------------------------------------*
  SELECT matnr maktx
    FROM makt
    INTO TABLE t_makt
    FOR ALL ENTRIES IN t_mara "Indica qual a tabela que usaremos como referência
    WHERE matnr EQ t_mara-matnr AND
          spras EQ 'PT'.

ENDIF.
*--------------------------------------------------------------------*
* União dos dados com lógica simples de leitura sequencial e leitura única com READ TABLE
*--------------------------------------------------------------------*
LOOP at t_mara into wa_mara.

"Encontra o registro correspondente a leitura da mara na tabela makt
  READ TABLE t_makt into wa_makt WITH KEY matnr = wa_mara-matnr.

  IF sy-subrc EQ 0. "Se encontrado, preencher todos os dados na tabela de saída
    wa_saida-matnr = wa_mara-matnr.
    wa_saida-mtart = wa_mara-mtart.
    wa_saida-maktx = wa_makt-maktx.
    APPEND wa_saida to t_saida. "Move os dados da estrutura de saída para a tabela interna
    CLEAR: wa_mara, "Limpa estruturas para evitar sujeiras nas próximas leituras pelo programa
           wa_makt,
           wa_saida.
  ENDIF.

ENDLOOP.