*&---------------------------------------------------------------------*
*&  Include  zrad_log_alv_top
*&---------------------------------------------------------------------*


**********************************************************************
* Grupo de types
**********************************************************************
TYPES: BEGIN OF ty_saida,
         uname TYPE sy-uname,
         datum TYPE sy-datum,
         uzeit TYPE sy-uzeit,
         matnr TYPE mseg-matnr,
         werks TYPE mseg-werks,
         lgort TYPE mseg-lgort,
         bwart TYPE mseg-bwart,
         wempf TYPE mseg-wempf,
       END OF ty_saida.

**********************************************************************
* Tabelas Internas
**********************************************************************

DATA: t_fieldcat TYPE slis_t_fieldcat_alv, "ALV structure
      t_log      TYPE TABLE OF ty_saida.

**********************************************************************
* Estrutura que define o layout do ALV
**********************************************************************

DATA: w_fieldcat TYPE slis_fieldcat_alv,
      w_layout   TYPE slis_layout_alv.