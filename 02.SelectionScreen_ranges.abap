*&---------------------------------------------------------------------*
*& Report Z_AD_AULA5_3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula5_3.

TABLES: mara,    " Table for Material Master Data
        ekpo,    " Table for Purchasing Document Item
        syst.    " System Status and Administrative Data

SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE text1.

SELECTION-SCREEN: SKIP.

" Selection option for the date
SELECT-OPTIONS: s_data FOR sy-datum.

SELECTION-SCREEN: SKIP.

" Selection option for Material Number
SELECT-OPTIONS: s-matnr FOR mara-matnr.

SELECTION-SCREEN: SKIP.

" Selection option for Plant
SELECT-OPTIONS: s-werks FOR ekpo-werks.

SELECTION-SCREEN: SKIP.

" Selection option for Purchasing Document
SELECT-OPTIONS: s-ebeln FOR ekpo-ebeln NO-EXTENSION.

SELECTION-SCREEN: SKIP.

" Selection option for Purchasing Document Item without intervals
SELECT-OPTIONS: s-ebelp FOR ekpo-ebelp NO-EXTENSION NO INTERVALS.

SELECTION-SCREEN: SKIP.

SELECTION-SCREEN: END OF BLOCK b1.

INITIALIZATION.
  text1 = 'Ranges'.   " Initializing the title for the selection block
