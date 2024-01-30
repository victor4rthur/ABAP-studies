*&---------------------------------------------------------------------*
*& Report Z_AD_AULA4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula4.

*DATA: v_variavel_1       TYPE c,                        "Declaro que a variável v_variável_1 é do tipo c
*      v_variavel_2(11)   TYPE c,                        "Declaro que a variável v_variável_2 é do tipo c e possui 11 espaços
*      v_variavel_3       TYPE mara-matnr,               "Declaro que a variável v_variável_3 é do tipo específico
*      v_variavel_4       TYPE n,                        "Numérica
*      v_variavel_4_2(10) TYPE n,                        "Numérica
*      v_variavel_5       TYPE p DECIMALS 2,             "Valor com decimais
*      v_variavel_6       TYPE d,                        "Data
*      v_variavel_7       TYPE t,                        "Hora
*      v_variavel_8       TYPE float,                    "Exponencial
*      v_variavel_9       TYPE i,                        "Inteiro
*      v_variavel_10      TYPE string.                   "String

*v_variavel_1 = 'a'.                                     "apenas um char seja num ou letras
*v_variavel_2 = 'Hello World'.
*v_variavel_3 = 'dezoito caracteres'.
*v_variavel_4 = 1.                                       "apenas um char sendo num
*v_variavel_4 = '1234567890'.
*v_variavel_5 = '3.14'.
*v_variavel_6 = '20240101'.
*v_variavel_7 = '190000'.
*v_variavel_8 = ' '.
*v_variavel_9 = '5'.
*v_variavel_10 = 'Palavras e frases'.

*WRITE: / v_variavel_1,
*       / v_variavel_2,
*       / v_variavel_3,
*       / v_variavel_4,
*       / v_variavel_4_2,
*       / v_variavel_5,
*       / v_variavel_6,
*       / v_variavel_7,
*       / v_variavel_8,
*       / v_variavel_9,
*       / v_variavel_10.

***Tipos de Estrutura
TYPES:
  BEGIN OF ty_estrutura,
         campo_1     TYPE c,
         campo_2(11) TYPE c,
         campo_3     TYPE mara-matnr,
         campo_4     TYPE n,
         campo_5(10) TYPE n,
         campo_6     TYPE p DECIMALS 2,
         campo_7     TYPE d,
         campo_8     TYPE t,
         campo_9     TYPE float,
         campo_10    TYPE i,
         campo_11    TYPE string,
  END OF ty_estrutura.

DATA: e_estrutura TYPE ty_estrutura.   " Declare a variable e_estrutura of type ty_estrutura

e_estrutura-campo_1 = 'A'.
e_estrutura-campo_2 = 'Hello World'.
e_estrutura-campo_3 = 'Dezoito caracteres'.
e_estrutura-campo_4 = 1.
e_estrutura-campo_5 = 1234567890.
e_estrutura-campo_6 = '3.14'.
e_estrutura-campo_7 = '20240101'.
e_estrutura-campo_8 = '190000'.
e_estrutura-campo_9 = ' '.
e_estrutura-campo_10 = '5'.
e_estrutura-campo_11 = 'Palavras e frases'.

*MODIFY tabela_sap FROM e_estrutura.