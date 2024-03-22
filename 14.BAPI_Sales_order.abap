*&---------------------------------------------------------------------*
*& Report ZAD_MASSS_CREATION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_masss_creation.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE title1.

"Order type (AUART)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) auarttxt FOR FIELD auart.
PARAMETERS: auart TYPE auart DEFAULT 'OR' OBLIGATORY.
SELECTION-SCREEN END OF LINE.

"Sales organization (VKORG)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) vkorgtxt FOR FIELD vkorg.
PARAMETERS: vkorg TYPE vkorg DEFAULT '1000'.
SELECTION-SCREEN END OF LINE.

"Distribution Channel (VTWEG)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) vtwegtxt FOR FIELD vtweg.
PARAMETERS: vtweg  TYPE vtweg DEFAULT '12'.
SELECTION-SCREEN END OF LINE.

"Division (SPART)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) sparttxt FOR FIELD spart.
PARAMETERS: spart TYPE spart  DEFAULT '00'.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN END OF LINE.

"Customer (KUNNR)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) kunnrtxt FOR FIELD kunnr.
PARAMETERS: kunnr TYPE kunnr DEFAULT '1012' OBLIGATORY.
SELECTION-SCREEN END OF LINE.

"Customer order number (BSTKD)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) bstkdtxt FOR FIELD bstkd.
PARAMETERS: bstkd TYPE bstkd DEFAULT '4500033566' OBLIGATORY.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN END OF LINE.

"MAterial number (MATNR)

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) matnrtxt FOR FIELD matnr.
PARAMETERS: matnr TYPE matnr DEFAULT 'AM2-GT' OBLIGATORY.
SELECTION-SCREEN END OF LINE.

"Order Quantity (kwmeng)
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) kwmengtx FOR FIELD kwmeng.
PARAMETERS: kwmeng TYPE kwmeng DEFAULT 1 OBLIGATORY.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE title2.

"Number of sales order to be created
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) auf_txt.
PARAMETERS: auf TYPE i DEFAULT 1 OBLIGATORY.
SELECTION-SCREEN END OF LINE.

"Number of sales order itens to be created ()
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT (35) itemstxt.
PARAMETERS: items TYPE i DEFAULT 1 OBLIGATORY.
SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK b2.


**********************************************************************
* Fields for BAPI_salesorder_createfromdata2
**********************************************************************
DATA: ls_order_header_in    TYPE bapisdhd1,
      lv_vbeln              TYPE bapivbeln-vbeln,
      ls_order_partners_in  TYPE bapiparnr,
      ls_order_items_in     TYPE bapisditm,
      ls_order_schedules_in TYPE bapischdl,
      ls_return             TYPE bapiret2.

DATA: lt_order_partners_in  TYPE STANDARD TABLE OF bapiparnr,
      lt_order_items_in     TYPE STANDARD TABLE OF bapisditm,
      lt_order_schedules_in TYPE STANDARD TABLE OF bapischdl,
      lt_return             TYPE STANDARD TABLE OF bapiret2.

DATA: lv_item_number        TYPE posnr_va.

FIELD-SYMBOLS:
               <fs_return> TYPE bapiret2.

DATA: lv_tstamp1 TYPE timestamp,
      lv_tstamp2 TYPE timestamp,
      lv_seconds TYPE i,
      lv_minutes TYPE i.

DATA: t1           TYPE i,
      t2           TYPE i,
      t0           TYPE i,
      lv_no_commit TYPE abap_bool.

*GUI Progress Indicator
DATA: lv_percentage TYPE p DECIMALS 2,
      lv_counter    TYPE i,
      text          TYPE text100,
      text2(4)      TYPE c.

INITIALIZATION.

  title1 = 'Data to create Sales Order'.
  title2 = 'Definition of # of SO'.

  auarttxt = 'Order Type'.
  vkorgtxt = 'Sales Organization'.
  vtwegtxt = 'Distribution Channel'.
  sparttxt = 'Division'.

  kunnrtxt = 'Sold-to Party'.
  bstkdtxt = 'Customer PO Number'.

  matnrtxt = 'Material Number'.
  kwmengtx = 'Order Quantity '.

  auf_txt = 'Number of Sales Order'.
  itemstxt = 'Number of items per SO'.

START-OF-SELECTION.
  "Preenchendo as variáveis
  "Header
  ls_order_header_in-doc_type = auart.
  ls_order_header_in-sales_org = vkorg.
  ls_order_header_in-distr_chan =  vtweg.
  ls_order_header_in-division = spart.
  ls_order_header_in-purch_no_c = bstkd.
  ls_order_header_in-req_date_h = sy-datum + 7.

  ls_order_partners_in-partn_role = 'AG'.
  ls_order_partners_in-partn_numb = kunnr.
  APPEND ls_order_partners_in TO lt_order_partners_in.

  lv_item_number = 0.
  DO items TIMES.
    lv_item_number = lv_item_number = + 10.
    ls_order_items_in-material = matnr.
    ls_order_items_in-itm_number = lv_item_number.
    ls_order_items_in-target_qty = kwmeng.
    ls_order_items_in-po_itm_no = ls_order_items_in-itm_number.
    APPEND ls_order_items_in TO lt_order_items_in.

    ls_order_schedules_in-itm_number = ls_order_items_in-itm_number.
    ls_order_schedules_in-sched_line = '0001'.
    ls_order_schedules_in-req_date = sy-datum + 7.
    ls_order_schedules_in-req_qty = kwmeng.
    APPEND ls_order_schedules_in TO lt_order_schedules_in.

  ENDDO.

  CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
    EXPORTING
      percentage = 0
      text       = '0 Sales Order completed'.

  "start
  CONVERT DATE sy-datum TIME sy-uzeit INTO TIME STAMP lv_tstamp1 TIME ZONE sy-zonlo.
  GET RUN TIME FIELD t0.

  "Create Sales Order using BAPI
  CLEAR lv_counter.

  DO auf TIMES.

    lv_counter = lv_counter + 1.
    CLEAR lt_return.

    CALL FUNCTION 'BAPI_SALESORDER_CREATEFROMDAT2'
      EXPORTING
        order_header_in    = ls_order_header_in
      IMPORTING
        salesdocument      = lv_vbeln
      TABLES
        return             = lt_return
        order_items_in     = lt_order_items_in
        order_schedules_in = lt_order_schedules_in
        order_partners     = lt_order_partners_in.

    LOOP AT lt_return ASSIGNING <fs_return> WHERE type = 'E' OR type = 'A'.
      lv_no_commit = abap_true.
      WRITE: 'Erro in Order Sales creation'.
      NEW-LINE.
      EXIT.
    ENDLOOP.

    IF lv_no_commit IS INITIAL.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        IMPORTING
          return = ls_return.

      WRITE AT 1 'SO created'.
      WRITE AT 15 lv_vbeln.
      WRITE AT 20 'at'.
      WRITE AT  24 sy-uzeit.
      NEW-LINE.
    ENDIF.

    lv_percentage = lv_counter / auf * 100.
    WRITE lv_counter TO text2.
    CONCATENATE text2 ' Sales Order Completed' INTO text.

    CALL FUNCTION 'SAPGUI_PROGRESS_INDICATOR'
      EXPORTING
        percentage = lv_percentage
        text        = text.

  ENDDO.

  CONVERT DATE sy-datum TIME sy-uzeit
          INTO TIME STAMP lv_tstamp2 TIME ZONE sy-zonlo.
  GET RUN TIME FIELD t1.

  "Diferença entre dois horários
  CALL FUNCTION 'SCSM_TIME_DIFF_GET'
    EXPORTING
      utc_start = lv_tstamp1
    CHANGING
      utc_end   = lv_tstamp2
      seconds   = lv_seconds
      minutes   = lv_minutes.

  t2 = t1 - t0.

  SKIP.
  WRITE AT 1 'Number of SO: '.
  WRITE AT 25 auf.
  NEW-LINE.
  WRITE AT 1 'Number of items per SO: '.
  WRITE AT 25 items.
  NEW-LINE.
  SKIP.

  WRITE at 1 'Duration  to create: Minutes'.
  write at 30 lv_minutes. new-line.
  write at 21 'Seconds'.
  write at 30 lv_seconds. NEW-LINE.
  write at 1 'Duration to create: Run time'.
  write at 30 t2.