*&---------------------------------------------------------------------*
*& Report Z_AD_AULA7
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula7.

*--------------------------------------------------------------------*
* Tipos "blueprint da tabela
*--------------------------------------------------------------------*
types: BEGIN OF ty_mara,
       matnr type mara-matnr,
       END OF ty_mara.

*--------------------------------------------------------------------*
*Tabela interna
*An internal table t_mara is declared with the structure of the previously defined type ty_mara. 
*Additionally, a work area w_mara of the same type is declared.
*--------------------------------------------------------------------*
DATA: t_mara TYPE TABLE OF ty_mara,
*--------------------------------------------------------------------*
* work area
*--------------------------------------------------------------------*
      w_mara TYPE ty_mara.

*--------------------------------------------------------------------*
* Tela de seleção
*This SELECT statement retrieves at most one row (UP TO 1 rows) from the mara table where the material number matches the user input (p_matnr).
*The result is stored in the internal table t_mara.
*--------------------------------------------------------------------*
PARAMETERS: p_matnr TYPE mara-matnr.

"Não performático pois selectiona todas as colunas e só usa uma.
*SELECT *
*FROM mara
*INTO TABLE t_mara
*WHERE matnr EQ p_matnr.
*
**  READ TABLE t_mara INTO wa_mara with key matnr = p_matnr.
*READ TABLE t_mara INTO w_mara INDEX 1.
*
*IF sy-subrc EQ 0.
*  WRITE: w_mara-matnr.
*ENDIF.


SELECT matnr
FROM mara UP TO 1 rows
INTO TABLE t_mara
WHERE matnr EQ p_matnr.
  
*--------------------------------------------------------------------*
* If the database query was successful (sy-subrc EQ 0), it reads the first (and only) entry from the internal table into the work area (READ TABLE t_mara INTO w_mara INDEX 1). 
*If the read is successful, it writes the material number to the output screen using the WRITE statement (WRITE: w_mara-matnr).
*--------------------------------------------------------------------*
IF sy-subrc EQ 0.
  READ TABLE t_mara INTO w_mara INDEX 1.
  IF sy-subrc EQ 0.
    WRITE: w_mara-matnr.
  ENDIF.
ENDIF.
