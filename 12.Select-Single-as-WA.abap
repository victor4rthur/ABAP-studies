*&---------------------------------------------------------------------*
*& Report z_ad_aula9_4
*&---------------------------------------------------------------------*
*&Uso do select single para popular variáveis
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_4.

DATA: v_maktx TYPE makt-maktx.                  "Descrição do material

PARAMETERS: p_matnr TYPE mara-matnr.


DATA: v_ersda TYPE mara-ersda,
      v_ernam TYPE mara-ernam,
      v_laeda TYPE mara-laeda,
      v_aenam TYPE mara-aenam,
      v_vpsta TYPE mara-vpsta,
      v_pstat TYPE mara-pstat.

SELECT SINGLE ersda
              ernam
              laeda
              aenam
              vpsta
              pstat
  FROM mara
  INTO (v_ersda, v_ernam, v_laeda, v_aenam, v_vpsta, v_pstat)
  WHERE matnr EQ p_matnr.