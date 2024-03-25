*&---------------------------------------------------------------------*
*& Report ZAD_MIGO
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_migo.

DATA: gm_header   TYPE bapi2017_gm_head_01.
DATA: gm_code     TYPE bapi2017_gm_code.
DATA: gm_headret  TYPE bapi2017_gm_head_ret.
DATA: gm_item     TYPE TABLE OF bapi2017_gm_item_create WITH HEADER LINE.
DATA: gm_return   TYPE bapiret2 OCCURS 0.
DATA: gm_retmtd   TYPE bapi2017_gm_head_ret-mat_doc.

CLEAR: gm_return, gm_retmtd.
REFRESH gm_return.

gm_header-pstng_date = sy-datum.
gm_header-doc_date = sy-datum.
gm_code-gm_code = '06'.

CLEAR: gm_item.
MOVE '501' TO gm_item-move_type.
MOVE '38' TO gm_item-material.
MOVE '1' TO gm_item-entry_qnt.
MOVE 'ST' TO gm_item-entry_uom.
MOVE '1710' TO gm_item-plant.
MOVE '171A' TO gm_item-stge_loc.
MOVE '17101101' TO gm_item-costcenter.

APPEND gm_item.

CALL FUNCTION 'BAPI_GOODSMVT_CREATE'
  EXPORTING
    goodsmvt_header  = gm_header
    goodsmvt_code    = gm_code
*   TESTRUN          = ' '
*   GOODSMVT_REF_EWM =
  IMPORTING
    goodsmvt_headret = gm_headret
    materialdocument = gm_retmtd
*   MATDOCUMENTYEAR  =
  TABLES
    goodsmvt_item    = gm_item
*   GOODSMVT_SERIALNUMBER         =
    return           = gm_return
*   GOODSMVT_SERV_PART_DATA       =
*   EXTENSIONIN      =
  .

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
  EXPORTING
    wait = 'X'.

WRITE: 'Receipt Document Number: ', gm_retmtd.