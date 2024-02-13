*&---------------------------------------------------------------------*
*& Report z_ad_aula9_3
*&---------------------------------------------------------------------*
*& Valida��o com select single
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_3.

DATA: v_maktx TYPE makt-maktx.                  "Descri��o do material

PARAMETERS: p_matnr TYPE mara-matnr.

IF p_matnr IS NOT INITIAL.


  SELECT SINGLE maktx
    FROM makt
    INTO v_maktx
    WHERE matnr EQ p_matnr AND
          spras EQ 'PT'.

          if sy-subrc NE 0.                       "Valida��o
            MESSAGE text-001 type 'S' display like 'E'.

          endif.
ENDIF.

WRITE: / 'Material', 'Descri��o do Material',
       / p_matnr, v_maktx.