*&---------------------------------------------------------------------*
*& Report Z_AD_AULA7_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula7_3.
TABLES: mara.

*--------------------------------------------------------------------*
*Grupo de Types
*--------------------------------------------------------------------*
TYPE-POOLS: slis.
TYPES: BEGIN OF ty_saida,
         matnr TYPE mara-matnr,
         ernam TYPE mara-ernam,
         laeda TYPE mara-laeda,
         aenam TYPE mara-aenam,
         vpsta TYPE mara-vpsta,
         pstat TYPE mara-pstat,
         lvorm TYPE mara-lvorm,
         mtart TYPE mara-mtart,
         mbrsh TYPE mara-mbrsh,
         matkl TYPE mara-matkl,
         bismt TYPE mara-bismt,
         meins TYPE mara-meins,
         bstme TYPE mara-bstme,
         zeinr TYPE mara-zeinr,
         zeiar TYPE mara-zeiar,
         zeivr TYPE mara-zeivr,
         zeifo TYPE mara-zeifo,
         aeszn TYPE mara-aeszn,
         blatt TYPE mara-blatt,
         blanz TYPE mara-blanz,
         ferth TYPE mara-ferth,
         formt TYPE mara-formt,
         groes TYPE mara-groes,
         wrkst TYPE mara-wrkst,
       END OF ty_saida.

*--------------------------------------------------------------------*
* Tabela interna
*--------------------------------------------------------------------*
DATA: t_fieldcat TYPE slis_t_fieldcat_alv. "Definição da estrutura do ALV
DATA: t_mara  TYPE TABLE OF ty_saida,
      t_saida TYPE TABLE OF ty_saida.

*--------------------------------------------------------------------*
*Estrutura do ALV
*--------------------------------------------------------------------*

DATA: w_fieldcat TYPE slis_fieldcat_alv, " estrutura de configuração da alv
      w_mara   TYPE mara,
      w_saida  TYPE ty_saida,
      w_layout type slis_layout_alv.
*--------------------------------------------------------------------*
* Tela de Seleção
*--------------------------------------------------------------------*
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_matnr FOR mara-matnr.
SELECTION-SCREEN: END OF BLOCK b1.

*--------------------------------------------------------------------*
* Inicio da lógica do programa
*--------------------------------------------------------------------*

START-OF-SELECTION.

  PERFORM f_seleciona_dados.
  PERFORM f_monta_fieldcat.
  PERFORM f_build_layout.
  PERFORM f_exibe_alv.


*&---------------------------------------------------------------------*
*&      Form  F_SELECIONA_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM f_seleciona_dados .

  SELECT matnr "Material Number
         ernam "Name of Person Who Created the Object
         laeda "Date of Last Change
         aenam "Name of person who changed object
         vpsta "Maintenance status of complete material
         pstat "Maintenance status
         lvorm "Flag Material for Deletion at Client Level
         mtart "Material Type
         mbrsh "Industry Sector
         matkl "Material Group
         bismt "Old material number
         meins "Base Unit of Measure
         bstme "Purchase Order Unit of Measure
         zeinr "Document number (without document management system)
         zeiar "Document type (without Document Management system)
         zeivr "Document version (without Document Management system)
         zeifo "Page format of document (without Document Management system)
         aeszn "Document change number (without document management system)
         blatt "Page number of document (without Document Management system)
         blanz "Number of sheets (without Document Management system)
         ferth "Production/inspection memo
         formt "Page Format of Production Memo
         groes "Size/dimensions
         wrkst "Basic Material
    FROM mara
    INTO TABLE t_mara
    WHERE matnr IN s_matnr.

  IF sy-subrc NE 0.
    MESSAGE 'Dados não encontrados' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_MONTA_FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM f_monta_fieldcat .

  w_fieldcat-fieldname = 'MATNR'.
  w_fieldcat-seltext_m = 'Material Number'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'ERNAM'.
  w_fieldcat-seltext_m = 'Created by'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'LAEDA'.
  w_fieldcat-seltext_m = 'Last Change'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'AENAM'.
  w_fieldcat-seltext_m = 'Changed by'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'VPSTA'.
  w_fieldcat-seltext_m = 'Complete status'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'PSTAT'.
  w_fieldcat-seltext_m = 'Maint. status'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'LVORM'.
  w_fieldcat-seltext_m = 'DF client level'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MTART'.
  w_fieldcat-seltext_m = 'Material Type'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MBRSH'.
  w_fieldcat-seltext_m = 'Industry Sector'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MATKL'.
  w_fieldcat-seltext_m = 'Material Group'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BISMT'.
  w_fieldcat-seltext_m = 'Old matl number'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'MEINS'.
  w_fieldcat-seltext_m = 'Base Unit'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BSTME'.
  w_fieldcat-seltext_m = 'Order Unit'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'ZEINR'.
  w_fieldcat-seltext_m = 'Document'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'ZEIAR'.
  w_fieldcat-seltext_m = 'Document type'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'ZEIVR'.
  w_fieldcat-seltext_m = 'Doc. Version'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.


  w_fieldcat-fieldname = 'ZEIFO'.
  w_fieldcat-seltext_m = 'Page format'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'AESZN'.
  w_fieldcat-seltext_m = 'Doc. change no.'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BLATT'.
  w_fieldcat-seltext_m = 'Page number'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'BLANZ'.
  w_fieldcat-seltext_m = 'No. of sheets'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'FERTH'.
  w_fieldcat-seltext_m = 'Prod./insp.memo'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'FORMT'.
  w_fieldcat-seltext_m = 'Page format'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'GROES'.
  w_fieldcat-seltext_m = 'Size/dimensions'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

  w_fieldcat-fieldname = 'WRKST'.
  w_fieldcat-seltext_m = 'Basic material'.
  APPEND w_fieldcat TO t_fieldcat.
  CLEAR w_fieldcat.

ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_BUILD_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_build_layout .
 w_layout-zebra = abap_true.
 w_layout-colwidth_optimize = abap_true.


ENDFORM.


*&---------------------------------------------------------------------*
*&      Form  F_EXIBE_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

FORM f_exibe_alv .

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
*     I_PROGRAM_NAME         =
*     I_INTERNAL_TABNAME     =
      i_structure_name       = 't_mara'     " Structure name (structure, table, view)
*     I_CLIENT_NEVER_DISPLAY = 'X'
*     I_INCLNAME             =
*     I_BYPASSING_BUFFER     =
*     I_BUFFER_ACTIVE        =
    CHANGING
      ct_fieldcat            = t_fieldcat   " Field catalogue with field descriptions
    EXCEPTIONS
      inconsistent_interface = 1             " Call parameter combination error
      program_error          = 2             " Program errors
      OTHERS                 = 3.
  .
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
          WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
 EXPORTING
*   I_INTERFACE_CHECK                 = ' '
*   I_BYPASSING_BUFFER                = ' '
*   I_BUFFER_ACTIVE                   = ' '
*   I_CALLBACK_PROGRAM                = ' '
*   I_CALLBACK_PF_STATUS_SET          = ' '
*   I_CALLBACK_USER_COMMAND           = ' '
*   I_CALLBACK_TOP_OF_PAGE            = ' '
*   I_CALLBACK_HTML_TOP_OF_PAGE       = ' '
*   I_CALLBACK_HTML_END_OF_LIST       = ' '
*   I_STRUCTURE_NAME                  =
*   I_BACKGROUND_ID                   = ' '
*   I_GRID_TITLE                      =
*   I_GRID_SETTINGS                   =
    IS_LAYOUT                         = w_layout
    IT_FIELDCAT                       = t_fieldcat
*   IT_EXCLUDING                      =
*   IT_SPECIAL_GROUPS                 =
*   IT_SORT                           =
*   IT_FILTER                         =
*   IS_SEL_HIDE                       =
*   I_DEFAULT                         = 'X'
*   I_SAVE                            = ' '
*   IS_VARIANT                        =
*   IT_EVENTS                         =
*   IT_EVENT_EXIT                     =
*   IS_PRINT                          =
*   IS_REPREP_ID                      =
*   I_SCREEN_START_COLUMN             = 0
*   I_SCREEN_START_LINE               = 0
*   I_SCREEN_END_COLUMN               = 0
*   I_SCREEN_END_LINE                 = 0
*   I_HTML_HEIGHT_TOP                 = 0
*   I_HTML_HEIGHT_END                 = 0
*   IT_ALV_GRAPHICS                   =
*   IT_HYPERLINK                      =
*   IT_ADD_FIELDCAT                   =
*   IT_EXCEPT_QINFO                   =
*   IR_SALV_FULLSCREEN_ADAPTER        =
* IMPORTING
*   E_EXIT_CAUSED_BY_CALLER           =
*   ES_EXIT_CAUSED_BY_USER            =
  TABLES
    t_outtab                          = t_mara
 EXCEPTIONS
   PROGRAM_ERROR                     = 1
   OTHERS                            = 2.
          .
IF sy-subrc <> 0.
 MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
ENDIF.


ENDFORM.