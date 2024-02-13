*&---------------------------------------------------------------------*
*& Report z_ad_aula9_10
*&---------------------------------------------------------------------*
*&Valida ou executa uma a��o ao mesmo tempo que faz uma sele��o
*& Pode tornar-se nao performatico em tabelas massivas
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_10.

TABLES: mara.

DATA: t_mara  TYPE TABLE OF mara,
      wa_mara TYPE mara.

SELECT-OPTIONS: s_matnr FOR mara-matnr.


"Select funcionando como leitura sequencial para validar alguma informa��o

SELECT *
FROM mara
INTO wa_mara "� necess�rio usar uma wa, pois a leitura sequencial
WHERE matnr IN s_matnr.


  IF wa_mara-matnr NE 'HALB'. "S� adiciona na T interna t_mara se for diferente de HALB.
    APPEND wa_mara TO t_mara.
  ENDIF.

ENDSELECT.

BREAK-POINT.