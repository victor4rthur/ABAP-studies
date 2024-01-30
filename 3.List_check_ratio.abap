*&---------------------------------------------------------------------*
*& Report Z_AD_AULA5_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula5_2.

" Selection screen block for various parameters
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME .
SELECTION-SCREEN SKIP.

* Bloco Dados do Material

" Block for Material Data
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text1.
PARAMETERS: p_matnr TYPE mara-matnr OBLIGATORY,  " Material Number parameter
            p_mtart TYPE mara-mtart,            " Material Type parameter
            p_data  TYPE sy-datum.              " Date parameter
SELECTION-SCREEN END OF BLOCK b2.
SELECTION-SCREEN SKIP.

" Block for Binary Selection
SELECTION-SCREEN BEGIN OF BLOCK b3 WITH FRAME TITLE text2.
PARAMETERS: p_r1 TYPE c RADIOBUTTON GROUP r1,   " Radio button option 1
            p_r2 TYPE c RADIOBUTTON GROUP r1.   " Radio button option 2
SELECTION-SCREEN END OF BLOCK b3.
SELECTION-SCREEN SKIP.

" Block for Multi-Selection
SELECTION-SCREEN BEGIN OF BLOCK b4 WITH FRAME TITLE text3.
PARAMETERS: p_check1 TYPE c AS CHECKBOX,  " Checkbox option 1
            p_check2 TYPE c AS CHECKBOX.  " Checkbox option 2
SELECTION-SCREEN END OF BLOCK b4.
SELECTION-SCREEN SKIP.

" Block for Listbox Selection
SELECTION-SCREEN BEGIN OF BLOCK b5 WITH FRAME TITLE text4.
PARAMETERS: p_list1 TYPE c AS LISTBOX VISIBLE LENGTH 10 OBLIGATORY,  " Listbox option 1
            p_list2 TYPE c AS LISTBOX VISIBLE LENGTH 20.            " Listbox option 2
SELECTION-SCREEN END OF BLOCK b5.
SELECTION-SCREEN SKIP.

" End of the main selection screen block
SELECTION-SCREEN END OF BLOCK b1.

" Initialization section
INITIALIZATION.

  text1 = 'Dados do Material'.         " Initializing title for Material Data block
  text2 = 'Seleção binária'.            " Initializing title for Binary Selection block
  text3 = 'Multiseleção'.               " Initializing title for Multi-Selection block
  text4 = 'Seleção de lista'.           " Initializing title for Listbox Selection block