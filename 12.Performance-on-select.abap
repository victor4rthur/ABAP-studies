*&---------------------------------------------------------------------*
*& Report z_ad_aula9_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_5.

TABLES: ekpo.

***DATA: t_ekpo TYPE TABLE OF ekpo.
***
***SELECT-OPTIONS: s_ebeln FOR ekpo-ebeln.
***
***select * Solu��o n�o perform�tico, pois seleciona mais itens do que o necess�rio
***from ekpo
***into TABLE t_ekpo
***where ebeln in s_ebeln.

*--------------------------------------------------------------------*
* Defini��o de estrutura para tabela interna
*--------------------------------------------------------------------*
TYPES: BEGIN OF ty_ekpo,
  ebeln TYPE ekpo-ebeln,
  ebelp TYPE ekpo-ebelp,
  loekz TYPE ekpo-loekz,
  statu TYPE ekpo-statu,
  aedat TYPE ekpo-aedat,
  txz01 TYPE ekpo-txz01,
  matnr TYPE ekpo-matnr,
  ematn TYPE ekpo-ematn,
  bukrs TYPE ekpo-bukrs,
  werks TYPE ekpo-werks,
  lgort TYPE ekpo-lgort,
  bednr TYPE ekpo-bednr,
  matkl TYPE ekpo-matkl,
  infnr TYPE ekpo-infnr,
  idnlf TYPE ekpo-idnlf,
  ktmng TYPE ekpo-ktmng,
  menge TYPE ekpo-menge,
  meins TYPE ekpo-meins,
  bprme TYPE ekpo-bprme,
       END OF ty_ekpo.

DATA: t_ekpo TYPE TABLE OF ty_ekpo.

*--------------------------------------------------------------------*
* Tela de sele��o com m�ltiplas escolhas da parte do usu�rio
*--------------------------------------------------------------------*
SELECT-OPTIONS: s_ebeln FOR ekpo-ebeln.

*--------------------------------------------------------------------*
* Selecionar todos os dados informados no range do Select-Options
*--------------------------------------------------------------------*
SELECT ebeln
       ebelp
       loekz
       statu
       aedat
       txz01
       matnr
       ematn
       bukrs
       werks
       lgort
       bednr
       matkl
       infnr
       idnlf
       ktmng
       menge
       meins
       bprme
  FROM ekpo
  INTO TABLE t_ekpo
  WHERE ebeln IN s_ebeln.