*&---------------------------------------------------------------------*
*& Report z_ad_aula8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula8.

DATA: t_bseg TYPE TABLE OF bseg,
      t_bkpf TYPE TABLE OF bkpf,
      w_mara TYPE mara,
      t_mara TYPE TABLE OF mara.

**********************************************************************
*N�o perform�tico!!
**********************************************************************

*Select * "Selecione todos os campos da tabela e coloque nesta outra
*from bseg
*into table t_bseg.

**********************************************************************
* Solu��o para selecionar de tabelas massivas
**********************************************************************

*Melhora a performance, pois limita a 100 linhas
"Tabela de cabe�alho
*SELECT *
*from bkpf up to 100 rows
*into table t_bkpf.


**********************************************************************
* Select Aninhado Deve-se evitar pois consome muito o banco de dados
**********************************************************************

"Tabela de cabe�alho
*SELECT *
*    FROM bkpf
*    INTO TABLE t_bkpf
*    PACKAGE SIZE 100.
*
*  SELECT *
*    FROM bseg
*    INTO TABLE t_bseg
*    FOR ALL ENTRIES IN t_bkpf
*    WHERE belnr EQ t_bkpf-belnr.
*
*ENDSELECT. " Quando o select tem endselect ele funciona como loop

**********************************************************************
* Solu��o perform�tica para o select aninhado
**********************************************************************

*PARAMETERS: p_belnr type bseg-belnr.
*
*"Tabela de cabe�alho
*SELECT *
*    FROM bkpf
*    INTO TABLE t_bkpf
*    WHERE belnr EQ p_belnr. "Condi��o de Sele��o
*
*
*IF sy-subrc EQ 0.
*  SELECT *
*  FROM bseg
*  INTO TABLE t_bseg
""" Todas as entradas que encontrar na bkpf vai buscar tbm
""" na bseg pois sao campos chave na mesma tabela
*  FOR ALL ENTRIES IN t_bkpf
*  WHERE belnr EQ t_bkpf-belnr.
*
*ENDIF.

**********************************************************************
* Select Single
* Select single seleciona apenas uma linha da tabela de BD assim como
* o READ Table l� apenas uma linha da tabela interna.
" Dessa forma ele s� � �til se vc usar a chave ta tabela no Where para
* que seja selecionado apenas uma linha e assim se possa popular uma wa
**********************************************************************

*SELECT single *
*    from mara
*    INTO w_mara
*    WHERE mtart EQ 1.

**********************************************************************
* Select Gen�rico, ou seja, onde a cl�usula where n�o foi fortemente
* especificada, com v�rias condi��es, visando restringir a sele��o.
**********************************************************************
*
*SELECT *
*    from mara
*    INTO TABLE t_mara
*    WHERE mtart EQ 'FERT' AND
*          ernam EQ '*'.

**********************************************************************
* Select em tabelas massivas usando cl�usula where baseada em tela de
* sele��o onde o preenchimento n�o � obrigat�rio
**********************************************************************

"Selecione o material baseado na tela de sele��o
"Caso o parameter n�o esteja obrigat�rio o programa ir� rodar e ir�
"selecionar todos as entradas da MARA consumindo muito o BD

*PARAMETERS: p_matnr TYPE mara-matnr OBLIGATORY. "Material a ser selecionado
*
*SELECT *
*FROM mara
*INTO TABLE t_mara
*WHERE matnr EQ p_matnr.
*
*IF sy-subrc EQ 0.
*
*    else.
*    "Mensagem de erro
*ENDIF.


**********************************************************************
* Indices para selects
**********************************************************************

*SELECT * FROM spfli
*WHERE cityfrom IN s_cityfrom
*      AND cityto IN s_cityto
*      %_HINTS ORACLE 'index("spfli" "spfli~001") LEADING ("SFLIGHT")'.