*&---------------------------------------------------------------------*
*& Report z_ad_aula9_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_6.

TABLES: vbrp.

DATA: v_brgew TYPE vbrp-brgew.              "Variável que retornará o maior valor


DATA: t_vbrp TYPE TABLE OF vbrp.            "Tabela interna para a seleção

SELECT-OPTIONS: s_vbeln for vbrp-vbeln.     "Seleção múltipla para documentos de faturamento

**--------------------------------------------------------------------*
** Seleciona o maior Peso Bruto (BRGEW) baseado na condição Where
**--------------------------------------------------------------------*
*SELECT MAX( brgew )                         "Só seleciona uma entrada mesmo se tiver mais de uma na tabela.
*  FROM vbrp
*  INTo v_brgew
*  WHERE vbeln IN s_vbeln.
*
*  BREAK-POINT.

*--------------------------------------------------------------------*
* Seleciona o menor Peso Bruto (BRGEW) baseado na condição Where
*--------------------------------------------------------------------*
SELECT MIN( brgew )
  FROM vbrp
  INTo v_brgew
  WHERE vbeln IN s_vbeln.

  BREAK-POINT.