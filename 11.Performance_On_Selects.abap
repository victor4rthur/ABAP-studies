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
*Não performático!!
**********************************************************************

*Select * "Selecione todos os campos da tabela e coloque nesta outra
*from bseg
*into table t_bseg.

**********************************************************************
* Solução para selecionar de tabelas massivas
**********************************************************************

*Melhora a performance, pois limita a 100 linhas
"Tabela de cabeçalho
*SELECT *
*from bkpf up to 100 rows
*into table t_bkpf.


**********************************************************************
* Select Aninhado Deve-se evitar pois consome muito o banco de dados
**********************************************************************

"Tabela de cabeçalho
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
* Solução performática para o select aninhado
**********************************************************************

*PARAMETERS: p_belnr type bseg-belnr.
*
*"Tabela de cabeçalho
*SELECT *
*    FROM bkpf
*    INTO TABLE t_bkpf
*    WHERE belnr EQ p_belnr. "Condição de Seleção
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
* o READ Table lê apenas uma linha da tabela interna.
" Dessa forma ele só é útil se vc usar a chave ta tabela no Where para
* que seja selecionado apenas uma linha e assim se possa popular uma wa
**********************************************************************

*SELECT single *
*    from mara
*    INTO w_mara
*    WHERE mtart EQ 1.

**********************************************************************
* Select Genérico, ou seja, onde a cláusula where não foi fortemente
* especificada, com várias condições, visando restringir a seleção.
**********************************************************************
*
*SELECT *
*    from mara
*    INTO TABLE t_mara
*    WHERE mtart EQ 'FERT' AND
*          ernam EQ '*'.

**********************************************************************
* Select em tabelas massivas usando cláusula where baseada em tela de
* seleção onde o preenchimento não é obrigatório
**********************************************************************

"Selecione o material baseado na tela de seleção
"Caso o parameter não esteja obrigatório o programa irá rodar e irá
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