*&---------------------------------------------------------------------*
*& Report z_ad_aula9_6
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_6.

TABLES: vbrp.

DATA: v_brgew TYPE vbrp-brgew.              "Vari�vel que retornar� o maior valor


DATA: t_vbrp TYPE TABLE OF vbrp.            "Tabela interna para a sele��o

SELECT-OPTIONS: s_vbeln for vbrp-vbeln.     "Sele��o m�ltipla para documentos de faturamento

**--------------------------------------------------------------------*
** Seleciona o maior Peso Bruto (BRGEW) baseado na condi��o Where
**--------------------------------------------------------------------*
*SELECT MAX( brgew )                         "S� seleciona uma entrada mesmo se tiver mais de uma na tabela.
*  FROM vbrp
*  INTo v_brgew
*  WHERE vbeln IN s_vbeln.
*
*  BREAK-POINT.

*--------------------------------------------------------------------*
* Seleciona o menor Peso Bruto (BRGEW) baseado na condi��o Where
*--------------------------------------------------------------------*
SELECT MIN( brgew )
  FROM vbrp
  INTo v_brgew
  WHERE vbeln IN s_vbeln.

  BREAK-POINT.