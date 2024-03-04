*&---------------------------------------------------------------------*
*&  Include  zrad_log_alv_frm
*&---------------------------------------------------------------------*


*******************************
* Validation
* Are all fields empty?
*******************************
FORM f_is_empty CHANGING c_error.  "form recebe var para erro. Neste caso c_error = lv_error.

  IF p_user   IS INITIAL AND
     p_date   IS INITIAL AND
     p_time   IS INITIAL AND
     p_mate   IS INITIAL AND
     p_centro IS INITIAL AND
     p_depos  IS INITIAL AND
     p_movim  IS INITIAL AND
     p_receb  IS INITIAL.

    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.




FORM f_seleciona_dados CHANGING c_error.   "form recebe var para erro. Neste caso c_error = lv_error.
  " É necessário tranformar para range, pois se algum
  " campo estiver vazio, este será ignorado.

  DATA: lr_userp TYPE RANGE OF sy-uname,
        lw_userp LIKE LINE OF lr_userp.

  DATA: lr_datep TYPE RANGE OF zdatep,
        lw_datep LIKE LINE OF lr_datep.

  DATA: lr_timez TYPE RANGE OF sy-uzeit,
        lw_timez LIKE LINE OF lr_timez.

  DATA: lr_matnumber TYPE RANGE OF matnr,
        lw_matnumber LIKE LINE OF lr_matnumber.

  DATA: lr_plant TYPE RANGE OF werks_d,
        lw_plant LIKE LINE OF lr_plant.

  DATA: lr_storagelocation TYPE RANGE OF lgort_d,
        lw_storagelocation LIKE LINE OF lr_storagelocation.

  DATA: lr_movtypeinventory TYPE RANGE OF bwart,
        lw_movtypeinventory LIKE LINE OF lr_movtypeinventory.

  DATA: lr_recipient TYPE RANGE OF wempf,
        lw_recipient LIKE LINE OF lr_recipient.

  IF p_user IS NOT INITIAL.

    lw_userp-sign = 'I'.
    lw_userp-option = 'EQ'.
    lw_userp-low = p_user.
    APPEND lw_userp TO lr_userp.

  ENDIF.

  IF p_date IS NOT INITIAL.

    lw_datep-sign = 'I'.
    lw_datep-option = 'EQ'.
    lw_datep-low = p_date.
    APPEND lw_datep TO lr_datep.

  ENDIF.

  IF p_time IS NOT INITIAL.

    lw_timez-sign = 'I'.
    lw_timez-option = 'EQ'.
    lw_timez-low = p_time.
    APPEND lw_timez TO lr_timez.

  ENDIF.

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

  SELECT zuserp
         zdatep
         ztimez
         zmatnr
         zwerks
         zdepos
         zbwart
         zwempf
  FROM ztad_log
  INTO TABLE t_log
  WHERE zuserp        IN lr_userp            AND
        zdatep        IN lr_datep            AND
        ztimez        IN lr_timez            AND
        zmatnr        IN lr_matnumber        AND
        zwerks        IN lr_plant            AND
        zdepos        IN lr_storagelocation  AND
        zbwart        IN lr_movtypeinventory AND
        zwempf        IN lr_recipient.

  IF sy-subrc NE 0.
    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
    c_error = abap_true.
  ENDIF.

ENDFORM.

FORM f_monta_fieldcat.
"Aqui deve-se mudar o nome da variavel posta no types

  w_fieldcat-fieldname = 'zNAME'.
  w_fieldcat-seltext_m = 'Usuário'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'DATUM'.
  w_fieldcat-seltext_m = 'Data'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'UZEIT'.
  w_fieldcat-seltext_m = 'Hora'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MATNR'.
  w_fieldcat-seltext_m = 'Material Number'.
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

  w_fieldcat-fieldname = 'BWART'.
  w_fieldcat-seltext_m = 'Movement'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'WEMPF'.
  w_fieldcat-seltext_m = 'Receiver'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.
ENDFORM.

FORM f_build_layout.
  w_layout-zebra = abap_true.
  w_layout-colwidth_optimize = abap_true.
ENDFORM.

FORM f_exibe_alv .

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'T_LOG'
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
      t_outtab      = t_log
    EXCEPTIONS
      program_error = 1
      OTHERS        = 2.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
             WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.