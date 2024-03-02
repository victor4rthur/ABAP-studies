*&---------------------------------------------------------------------*
*&  Include  zrad_ext_dados_top
*&---------------------------------------------------------------------*

TABLES: mseg,
        mkpf.

**********************************************************************
* Grupo de types
**********************************************************************

TYPES: BEGIN OF ty_dados,
         matnr TYPE mseg-matnr,
         werks TYPE mseg-werks,
         lgort TYPE mseg-lgort,
         bwart TYPE mseg-bwart,
         wempf TYPE mseg-wempf,
         budat TYPE mkpf-budat,
       END OF ty_dados.

TYPES: BEGIN OF ty_linhas,
         linha TYPE string,
       END OF ty_linhas.

**********************************************************************
* Tabelas Internas / WA
**********************************************************************

DATA: t_dados  TYPE TABLE OF ty_dados,
      t_linha  TYPE TABLE OF ty_linhas,
      lw_linha LIKE LINE OF t_linha,
      lw_dados LIKE LINE OF t_dados.