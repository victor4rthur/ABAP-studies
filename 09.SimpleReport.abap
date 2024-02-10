*&---------------------------------------------------------------------*
*& Report Z_AD_AULA6_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula6_4.
TABLES: ekko.

*--------------------------------------------------------------------*
* TIPOS
*--------------------------------------------------------------------*
TYPES: BEGIN OF ty_saida,
         ebeln TYPE ekko-ebeln,  " Purchase Order Number
         ebelp TYPE ekpo-ebelp,  " Item Number
         matnr TYPE mara-matnr,  " Material Number
         maktx TYPE makt-maktx,  " Material Description
       END OF ty_saida.

" Work Area
DATA: wa_ekko  TYPE ekko,   " Work Area for Purchase Order Header
      wa_ekpo  TYPE ekpo,   " Work Area for Purchase Order Item
      wa_saida TYPE ty_saida,  " Work Area for Custom Output
      wa_makt  TYPE makt.
*--------------------------------------------------------------------*
*Tabela interna
*--------------------------------------------------------------------*
DATA: t_saida TYPE TABLE OF ty_saida,  " Internal Table for Custom Output
      t_ekko  TYPE TABLE OF ekko,     " Internal Table for Purchase Order Header
      t_ekpo  TYPE TABLE OF ekpo,     " Internal Table for Purchase Order Item
      t_makt  TYPE TABLE OF makt.     " Internal Table for Material Descriptions

*--------------------------------------------------------------------*
"Tela de seleção
*--------------------------------------------------------------------*
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_ebeln FOR ekko-ebeln.  " Selection Screen for Purchase Order Number
SELECTION-SCREEN: END OF BLOCK b1.

START-OF-SELECTION. "início da lógica principal
  "Seleção de dados
  PERFORM f_selecao_de_dados.   " Perform data selection
  PERFORM  f_monta_dados.        " Perform data assembly
  PERFORM f_exibe_dados.         " Perform data display


*&---------------------------------------------------------------------*
*&      Form  F_SELECAO_DE_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_selecao_de_dados .

  " Select a range of purchase orders from the header table
  SELECT *
    FROM ekko
    INTO TABLE t_ekko
    WHERE ebeln IN s_ebeln.

  IF sy-subrc EQ 0.
    " Based on the previous selection, select items
    SELECT *
      FROM ekpo
      INTO TABLE t_ekpo
      FOR ALL ENTRIES IN t_ekko " For all entries in the T_EKKO table
      WHERE ebeln EQ t_ekko-ebeln.

    IF sy-subrc EQ 0.
      " Select material descriptions for selected items and language 'PT'
      SELECT *
      FROM makt
      INTO TABLE t_makt
      FOR ALL ENTRIES IN t_ekpo
      WHERE matnr EQ t_ekpo-matnr AND
            spras EQ 'PT'.

    ENDIF.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  F_MONTA_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_monta_dados .


  LOOP AT t_ekpo INTO wa_ekpo.

    IF wa_ekpo-matnr IS NOT INITIAL.

      READ TABLE t_ekko INTO wa_ekko WITH KEY ebeln = wa_ekpo-ebeln.

      IF sy-subrc EQ 0.
        wa_saida-ebeln = wa_ekko-ebeln.
        wa_saida-ebelp = wa_ekpo-ebelp.
        wa_saida-matnr = wa_ekpo-matnr.

        READ TABLE t_makt INTO wa_makt WITH KEY matnr = wa_ekpo-matnr.

        IF sy-subrc EQ 0.
          wa_saida-maktx = wa_makt-maktx.
        ENDIF.
      ENDIF.

      IF wa_saida-maktx IS INITIAL.
        wa_saida-maktx = 'Sem Descrição.'.
      ENDIF.

      APPEND wa_saida TO t_saida.
    ENDIF.
  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_EXIBE_DADOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_exibe_dados .

  "One way display
*  LOOP AT t_saida INTO wa_saida.
*    WRITE: / '|', 'Pedido:',                wa_saida-ebeln,
*           / '|', 'Item:',                  wa_saida-ebelp,
*           / '|', 'Material:',              wa_saida-matnr,
*           / '|', 'Descrição do Material:', wa_saida-maktx.
*  ENDLOOP.

  "other way
  WRITE: / ,'|', 'Pedido:   ', '|','|','Item:','|','|','Material:         ','|','|','Descrição do Material:'.
  LOOP AT t_saida INTO wa_saida.
    WRITE: / ,'|',wa_saida-ebeln,'|','|',wa_saida-ebelp,'|','|',wa_saida-matnr,'|','|',wa_saida-maktx,'|'.
  ENDLOOP.
ENDFORM.
