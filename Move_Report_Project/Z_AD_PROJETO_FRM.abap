*&---------------------------------------------------------------------*
*&  Include  z_ad_projeto_frm
*&---------------------------------------------------------------------*


*******************************
* Validation
* Are all fields empty?
*******************************
FORM f_is_empty CHANGING c_error. "parametro modificador de entrada
"only run if some var is passed

  IF p_mate   IS INITIAL AND
     p_centro IS INITIAL AND
     p_depos  IS INITIAL AND
     p_movim  IS INITIAL AND
     p_receb  IS INITIAL.

    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.

  ENDIF.

ENDFORM.

*******************************
* Validation
* Does the inputs matches is
* the master table?
*******************************
FORM f_mate_matches CHANGING c_error.
  CHECK p_mate IS NOT INITIAL.

  SELECT COUNT(*)
  FROM mara
  WHERE matnr = p_mate.

  IF sy-subrc NE 0.
* O valor informado não existe na tabela MARA.
    MESSAGE TEXT-004 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

FORM f_centro_matches CHANGING c_error.
  CHECK p_centro IS NOT INITIAL.

  SELECT SINGLE COUNT(*)
   FROM t001w
   WHERE werks = p_centro.

  IF sy-subrc NE 0.
* O valor informado não existe na tabela t001w.
    MESSAGE TEXT-005 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.
ENDFORM.

FORM f_depos_matches CHANGING c_error.
  CHECK p_depos IS NOT INITIAL.

  SELECT SINGLE COUNT(*)
   FROM t001l
   WHERE lgort = p_depos.

  IF sy-subrc NE 0.
* O valor informado não existe na tabela T001L.
    MESSAGE TEXT-006 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.
ENDFORM.

FORM f_movim_matches CHANGING c_error.

  CHECK p_movim IS NOT INITIAL.

  SELECT SINGLE COUNT(*)
   FROM t156
   WHERE bwart = p_movim.

  IF sy-subrc NE 0.
* O valor informado não existe na tabela T156.
    MESSAGE TEXT-007 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

FORM f_receb_matches CHANGING c_error.

  CHECK p_receb IS NOT INITIAL.

  SELECT SINGLE COUNT(*)
   FROM mseg
   WHERE wempf = p_receb.

  IF sy-subrc NE 0.
* O valor informado não existe na tabela mseg.
    MESSAGE TEXT-008 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

*******************************
* Validation
* Does the range has more then
* 24 months?
*******************************

FORM f_is_recent CHANGING c_error.

  CHECK s_date IS NOT INITIAL.

  IF ( s_date-high - s_date-low ) > 730.
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

" End Validations

**********************************************************************
* Seleciona os dados para o ALV com CDS View
**********************************************************************
FORM f_seleciona_dados CHANGING c_error.

  DATA: lr_matnumber TYPE RANGE OF matnr,
        lw_matnumber LIKE LINE OF lr_matnumber.

  DATA: lr_storagelocation TYPE RANGE OF lgort_d,
        lw_storagelocation LIKE LINE OF lr_storagelocation.

  DATA: lr_movtypeinventory TYPE RANGE OF bwart,
        lw_movtypeinventory LIKE LINE OF lr_movtypeinventory.

  DATA: lr_recipient TYPE RANGE OF wempf,
        lw_recipient LIKE LINE OF lr_recipient.

  DATA: lr_plant TYPE RANGE OF werks_d,
        lw_plant LIKE LINE OF lr_plant.

  IF p_mate IS NOT INITIAL.

    lw_matnumber-sign = 'I'.
    lw_matnumber-option = 'EQ'.
    lw_matnumber-low = p_mate.
    APPEND lw_matnumber TO lr_matnumber.

  ENDIF.

  IF p_centro IS NOT INITIAL.

    lw_plant-sign = 'I'.
    lw_plant-option = 'EQ'.
    lw_plant-low = p_centro.
    APPEND lw_plant TO lr_plant.

  ENDIF.

  IF p_depos IS NOT INITIAL.

    lw_storagelocation-sign = 'I'.
    lw_storagelocation-option = 'EQ'.
    lw_storagelocation-low = p_depos.
    APPEND lw_storagelocation  TO lr_storagelocation.

  ENDIF.

  IF p_movim IS NOT INITIAL.

    lw_movtypeinventory-sign = 'I'.
    lw_movtypeinventory-option = 'EQ'.
    lw_movtypeinventory-low = p_movim.
    APPEND lw_movtypeinventory TO lr_movtypeinventory.

  ENDIF.

  IF p_receb IS NOT INITIAL.

    lw_recipient-sign = 'I'.
    lw_recipient-option = 'EQ'.
    lw_recipient-low = p_receb.
    APPEND lw_recipient        TO lr_recipient.

  ENDIF.

  SELECT *
  FROM zcds_mov_material
  INTO TABLE @t_movemat
  " É necessário tranformar para range, pois se algum
  " campo estiver vazio, este será ignorado.
  WHERE matnumber        IN @lr_matnumber        AND
        plant            IN @lr_plant            AND
        storagelocation  IN @lr_storagelocation  AND
        movtypeinventory IN @lr_movtypeinventory AND
        recipient        IN @lr_recipient        AND
        postdate         IN @s_date.

  IF sy-subrc NE 0.
    MESSAGE TEXT-009 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

**********************************************************************
*LOG de execução
**********************************************************************

FORM f_log CHANGING c_error.

  DATA: w_log TYPE ztad_log.

  w_log-zmandt = sy-mandt.
  w_log-zuserp = sy-uname.
  w_log-zdatep = sy-datum.
  w_log-ztimez = sy-uzeit.
  w_log-zmatnr = p_mate.
  w_log-zwerks = p_centro.
  w_log-zdepos = p_depos.
  w_log-zbwart = p_movim.
  w_log-zwempf = p_receb.

  MODIFY ztad_log FROM w_log.

  IF sy-subrc EQ 0.
    COMMIT WORK.
    MESSAGE TEXT-011 TYPE 'S'.
  ELSE.
    MESSAGE TEXT-010 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.



ENDFORM.

**********************************************************************
* Extração dos dados
**********************************************************************

FORM f_extra_dados.

  DATA: t_extra  TYPE TABLE OF ztad_ext_dados.
"Loop na t_movemat passando os campos para a s_extra linha por linha que
"faz append automático para t_extra

  t_extra = VALUE #( FOR s_extra IN t_movemat ( zmandt = sy-mandt
                                                zmatnr = s_extra-matnr
                                                zwerks = s_extra-werks
                                                zlgort = s_extra-lgort
                                                zmaktx = s_extra-maktx
                                                zbwart = s_extra-bwart
                                                zbtext = s_extra-btext
                                                zbudat = s_extra-budat
                                                zwempf = s_extra-wempf
                                                zsgtxt = s_extra-sgtxt
                                                zmenge = s_extra-menge
                                                zmeins = s_extra-meins
                                                zmblnr = s_extra-mblnr
                                                zcharg = s_extra-charg
                                                zdmbtr = s_extra-dmbtr
                                                zexbwr = s_extra-exbwr ) ).

  IF sy-subrc EQ 0.
    MODIFY ztad_ext_dados FROM TABLE t_extra.

    IF sy-subrc EQ 0.
      COMMIT WORK.
    ENDIF.
  ENDIF.
ENDFORM.

**********************************************************************
* Monta o ALV.
**********************************************************************
FORM f_monta_fieldcat.
"Aqui deve-se mudar o nome da variavel posta no types

  w_fieldcat-fieldname = 'MBLNR'.
  w_fieldcat-seltext_m = 'Material Doc.'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'ZEILE'.
  w_fieldcat-seltext_m = 'Item in Mat Doc.'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MATNR'.
  w_fieldcat-seltext_m = 'Material Number'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MAKTX'.
  w_fieldcat-seltext_m = 'Material Descr.'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BWART'.
  w_fieldcat-seltext_m = 'Movement'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BTEXT'.
  w_fieldcat-seltext_m = 'Movement Descr.'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'WERKS'.
  w_fieldcat-seltext_m = 'Material Center'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'LGORT'.
  w_fieldcat-seltext_m = 'Deposit'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BUDAT'.
  w_fieldcat-seltext_m = 'Date'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'WEMPF'.
  w_fieldcat-seltext_m = 'Receiver'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'SGTXT'.
  w_fieldcat-seltext_m = 'Text'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MENGE'.
  w_fieldcat-seltext_m = 'Register Amount'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MEINS'.
  w_fieldcat-seltext_m = 'Unit of Measure'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'CHARG'.
  w_fieldcat-seltext_m = 'Batch'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'DMBTR'.
  w_fieldcat-seltext_m = 'External Amount'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'EXBWR'.
  w_fieldcat-seltext_m = 'MI Exter. Amount.'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

ENDFORM.

**********************************************************************
* Estiliza o ALV.
**********************************************************************
FORM f_build_layout.

  w_layout-zebra = abap_true.
  w_layout-colwidth_optimize = abap_true.

ENDFORM.

**********************************************************************
* Exibe o ALV.
**********************************************************************
FORM f_exibe_alv .

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'T_MOVEMAT'
    CHANGING
      ct_fieldcat            = t_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = w_layout
      it_fieldcat   = t_fieldcat
    TABLES
      t_outtab      = t_movemat
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


ENDFORM.