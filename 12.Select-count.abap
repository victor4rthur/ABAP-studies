*&---------------------------------------------------------------------*
*& Report z_ad_aula9_7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_7.


DATA: t_vbak TYPE TABLE OF vbak.

DATA: v_count TYPE i.                   "Vari�vel utilizada para o contador (Tipo I)

PARAMETERS: p_auart TYPE vbak-auart.    "Par�metro de Entrada para o tipo de doc de venda

*--------------------------------------------------------------------*
* Contar quantos registros atendem a condi��o do Select
*--------------------------------------------------------------------*
SELECT COUNT(*) INTO v_count            "Mais performatico do que o describe table
  FROM vbak
  WHERE auart EQ p_auart.

  BREAK-POINT.