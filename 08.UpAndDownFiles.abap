*&---------------------------------------------------------------------*
*& Report Z_AD_AULA7_2
*&---------------------------------------------------------------------*
*& Este é um programa simples que realiza o upload de um arquivo CSV   *
*& e exibe os campos resultantes após a divisão (split) das linhas do   *
*& arquivo.                                                            *
*&---------------------------------------------------------------------*
REPORT z_ad_aula7_2.

*---------------------------------------------------------------------*
* Declaração do tipo de dados "ty_arquivo" que representa uma linha   *
* de um arquivo com um campo de 500 caracteres.                       *
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_arquivo,
         linha(500) TYPE c,
       END OF ty_arquivo.

*---------------------------------------------------------------------*
* Declaração do tipo de dados "ty_convert" para armazenar os campos   *
* convertidos do arquivo.                                             *
*---------------------------------------------------------------------*
TYPES: BEGIN OF ty_convert,
         campo1(13)  TYPE c,
         campo2(13)  TYPE c,
         campo3(13)  TYPE c,
         campo4(13)  TYPE c,
         campo5(13)  TYPE c,
         campo6(13)  TYPE c,
         campo7(13)  TYPE c,
         campo8(13)  TYPE c,
         campo9(13)  TYPE c,
         campo10(13) TYPE c,
       END OF ty_convert.
*---------------------------------------------------------------------*
* Declaração de variáveis: tabela interna, área de trabalho e nome do *
* arquivo.                                                            *
*---------------------------------------------------------------------*
DATA: t_arquivo  TYPE TABLE OF ty_arquivo,
      wa_arquivo TYPE ty_arquivo,
      v_file     TYPE string.

DATA: t_convert TYPE TABLE OF ty_convert,
      w_convert TYPE ty_convert.

*---------------------------------------------------------------------*
* Tela de seleção: Bloco 'b1' com um campo para o nome do arquivo.    *
*---------------------------------------------------------------------*
SELECTION-SCREEN: BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_file TYPE rlgrap-filename.
PARAMETERS: p_down TYPE  rlgrap-filename.
SELECTION-SCREEN: END OF BLOCK b1.

AT SELECTION-SCREEN OUTPUT.

  p_down = p_file.

*---------------------------------------------------------------------*
* Tratamento de evento: Ao pressionar F4 no campo de seleção de arquivo*
*---------------------------------------------------------------------*
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'
    EXPORTING
      program_name  = syst-cprog
      dynpro_number = syst-dynnr
    IMPORTING
      file_name     = p_file.

*---------------------------------------------------------------------*
* Início da execução do programa. Chamada do formulário para upload do *
* arquivo.                                                             *
*---------------------------------------------------------------------*
START-OF-SELECTION.
  PERFORM f_upload_file.
  PERFORM f_download_file.

*&---------------------------------------------------------------------*
*&      Form  F_UPLOAD_FILE
*&---------------------------------------------------------------------*
*       Realiza o upload de um arquivo e processa os dados.
*----------------------------------------------------------------------*
FORM f_upload_file .





*---------------------------------------------------------------------*
* Atribui o nome do arquivo ao campo local.                           *
*---------------------------------------------------------------------*
  v_file = p_file.

*---------------------------------------------------------------------*
* Chama a função para realizar o upload do arquivo para a tabela      *
* interna "t_arquivo".                                                *
*---------------------------------------------------------------------*
  CALL FUNCTION 'GUI_UPLOAD'
    EXPORTING
      filename = v_file
      filetype = 'ASC'
    TABLES
      data_tab = t_arquivo.

*---------------------------------------------------------------------*
* Loop para processar cada linha do arquivo e realizar a conversão    *
* dos campos separados por ';'.                                      *
*---------------------------------------------------------------------*
  LOOP AT t_arquivo INTO wa_arquivo.
    SPLIT wa_arquivo-linha AT ';' INTO w_convert-campo1
                                       w_convert-campo2
                                       w_convert-campo3
                                       w_convert-campo4
                                       w_convert-campo5
                                       w_convert-campo6
                                       w_convert-campo7
                                       w_convert-campo8
                                       w_convert-campo9
                                       w_convert-campo10.


    TRANSLATE: w_convert-campo1   USING '03',
               w_convert-campo2   USING '04',
               w_convert-campo3   USING '05',
               w_convert-campo4   USING '06',
               w_convert-campo5   USING '07',
               w_convert-campo6   USING '08',
               w_convert-campo7   USING '09',
               w_convert-campo8   USING '00',
               w_convert-campo9   USING '01',
               w_convert-campo10  USING '02'.
*---------------------------------------------------------------------*
* Verifica se a operação de split foi bem-sucedida e, se sim, adiciona *
* a linha convertida à tabela interna "lt_convert".                   *
*---------------------------------------------------------------------*

    APPEND w_convert TO t_convert.

*---------------------------------------------------------------------*
* Exibe os valores dos campos após o split na tela.                   *
*---------------------------------------------------------------------*
    WRITE: / 'Campo 1:', w_convert-campo1,
           / 'Campo 2:', w_convert-campo2,
           / 'Campo 3:', w_convert-campo3,
           / 'Campo 4:', w_convert-campo4,
           / 'Campo 5:', w_convert-campo5,
           / 'Campo 6:', w_convert-campo6,
           / 'Campo 7:', w_convert-campo7,
           / 'Campo 8:', w_convert-campo8,
           / 'Campo 9:', w_convert-campo9,
           / 'Campo 10:', w_convert-campo10.


  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*&      Form  F_DOWNLOAD_FILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_download_file .

  DATA: lv_filename TYPE string.

  lv_filename = p_down.


  CALL FUNCTION 'GUI_DOWNLOAD'
    EXPORTING
      filename = lv_filename
*     FILETYPE = 'ASC'
*
    TABLES
      data_tab = t_convert.
*
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
