*&---------------------------------------------------------------------*
*&  Include  z_ad_projeto_top
*&---------------------------------------------------------------------*

TABLES: mkpf.

**********************************************************************
* Grupo de Types
**********************************************************************
TYPES: BEGIN OF ty_saida,
         mblnr TYPE mseg-mblnr,  "Material doc
         zeile TYPE mseg-zeile,  "Item in Material Document
         matnr TYPE mseg-matnr,  "Material Number
         maktx TYPE makt-maktx,  "Material description
         bwart TYPE mseg-bwart,  "Movement
         btext TYPE t156t-btext, "Movement description
         werks TYPE mseg-werks,  "Material Center
         lgort TYPE mseg-lgort,  "Deposit
         budat TYPE mkpf-budat,  "Date
         wempf TYPE mseg-wempf,  "Receiver
         sgtxt TYPE mseg-sgtxt,  "text
         menge TYPE mseg-menge,  "Register amount
         meins TYPE mseg-meins,  "unit of measurement
         charg TYPE mseg-charg,  "batch
         dmbtr TYPE mseg-dmbtr,  "External amount
         exbwr TYPE mseg-exbwr,  "MI External amount
       END OF ty_saida.

**********************************************************************
* Tabelas Internas
**********************************************************************

DATA: t_fieldcat TYPE slis_t_fieldcat_alv, "ALV structure
      t_movemat  TYPE TABLE OF ty_saida.

**********************************************************************
* Estrutura que define o layout do ALV
**********************************************************************

DATA: w_fieldcat TYPE slis_fieldcat_alv,
      w_layout   TYPE slis_layout_alv.

**********************************************************************
* VAR globais
**********************************************************************

DATA: lv_error TYPE boolean.  "variavel para tratar erros