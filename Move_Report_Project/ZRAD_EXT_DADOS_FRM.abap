*&---------------------------------------------------------------------*
*&  Include  zrad_ext_dados_frm
*&---------------------------------------------------------------------*


*******************************
* Validation
* Are all fields empty?
*******************************
FORM f_is_empty .

  IF s_mate   IS INITIAL AND
     s_centro IS INITIAL AND
     s_movim  IS INITIAL AND
     s_depos  IS INITIAL AND
     s_receb  IS INITIAL AND
     s_date   IS INITIAL.

    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING. " encerra o código após mensagem de erro. Substitui a criacao de uma var para tratar erro


  ENDIF.

  IF p_down IS INITIAL.
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.

  ENDIF.

ENDFORM.

**********************************************************************
*Seleção de dados para Download
**********************************************************************

FORM f_seleciona_dados CHANGING c_error TYPE boolean.
  "form recebe var para erro. Neste caso c_error = lv_error.

  SELECT zmatnr zwerks zlgort zbwart zwempf zbudat
    FROM ztad_ext_dados
    INTO TABLE t_dados
    WHERE zmatnr IN s_mate   AND "Para Selectoption usa-se IN
          zwerks IN s_centro AND
          zlgort IN s_movim  AND
          zbwart IN s_depos  AND
          zwempf IN s_receb  AND
          zbudat IN s_date.

  IF sy-subrc NE 0.
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

**********************************************************************
*Organização de dados para Download
**********************************************************************

FORM f_monta_arquivo.

  LOOP AT t_dados INTO lw_dados.

    CONCATENATE lw_dados-matnr
                lw_dados-werks
                lw_dados-lgort
                lw_dados-bwart
                lw_dados-wempf
                lw_dados-budat
    INTO lw_linha-linha
    SEPARATED BY ';'.

    APPEND lw_linha TO t_linha.

  ENDLOOP.

ENDFORM.

**********************************************************************
*Download do Arquivo
**********************************************************************

FORM f_download.

" Declaração de uma var tipo string cujo nome é o nome do arquivo
  CONCATENATE p_down '\DATA_HORA_MOVIMENTO.TXT' INTO DATA(lv_filename).

  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename = lv_filename
      filetype = 'ASC'
    TABLES
      data_tab = t_linha.

  IF sy-subrc <> 0.
    MESSAGE TEXT-004 TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

ENDFORM.