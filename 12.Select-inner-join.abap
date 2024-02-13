*&---------------------------------------------------------------------*
*& Report z_ad_aula9_8
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_ad_aula9_8.

*--------------------------------------------------------------------*
* Definição de estrutura com os dados das duas tabelas
*--------------------------------------------------------------------*
TYPES: BEGIN OF ty_material,
  matnr TYPE mara-matnr,
  mtart TYPE mara-mtart,
  maktx TYPE makt-maktx,
       END OF ty_material.

*--------------------------------------------------------------------*
* Tabela interna que vai receber os dados das duas tabelas
*--------------------------------------------------------------------*
DATA: t_material TYPE TABLE OF ty_material.

*--------------------------------------------------------------------*
* Parâmetro de entrada para o campo Material
*--------------------------------------------------------------------*
PARAMETERS: p_matnr TYPE mara-matnr.

*--------------------------------------------------------------------*
* Seleção INNER JOIN das tabelas MARA e MAKT
*--------------------------------------------------------------------*
"Forma simples
SELECT mara~matnr mara~mtart makt~maktx
  FROM mara AS mara                     "O Comando AS nomeia um Alias(apelido) para a tabela
  INNER JOIN makt AS makt               "O INNER JOIN faz a junção da tabela indicando também o apelido para a segunda tabela
  ON mara~matnr EQ makt~matnr           "As tabelas devem estar ligadas entre si por campos comuns através do comando ON
  INTO TABLE t_material
  WHERE mara~matnr EQ p_matnr AND
        makt~spras EQ 'PT'.

"Forma usual
*SELECT A~matnr A~mtart B~maktx
*  FROM mara AS A                     "O Comando AS nomeia um Alias(apelido) para a tabela
*  INNER JOIN makt AS B               "O INNER JOIN faz a junção da tabela indicando também o apelido para a segunda tabela
*  ON A~matnr EQ B~matnr              "As tabelas devem estar ligadas entre si por campos comuns através do comando ON
*  INTO TABLE t_material
*  WHERE A~matnr EQ p_matnr AND
*        B~spras EQ 'PT'.


  BREAK-POINT.