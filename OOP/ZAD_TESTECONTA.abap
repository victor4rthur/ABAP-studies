*&---------------------------------------------------------------------*
*& Report zad_testeconta
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_testeconta.

"Criar um novo objeto do tipo da classe com os construtores necess�rios
DATA(o_novaconta)  = new zadcl_bank_account(
    i_const_saldo  = 0
    i_const_status = abap_false
).

"O objeto criado usa o m�todo abrir conta com os construtores necess�rios
o_novaconta->zad_i_bank~abrirconta(
  EXPORTING
    tipodeconta = 'CC'
    nome        = 'Vov�'
).

"Escreve o m�todo status e saldo do objeto
write: o_novaconta->get_status(  ),
       o_novaconta->get_saldo(  ),
       o_novaconta->get_dono(  ),
       o_novaconta->get_numconta(  ).

**********************************************************************

"Criar um novo objeto do tipo da classe com os construtores necess�rios
DATA(o_novaconta2)  = new zadcl_bank_account(
    i_const_saldo  = 0
    i_const_status = abap_false
).

"O objeto criado usa o m�todo abrir conta com os construtores necess�rios
o_novaconta2->zad_i_bank~abrirconta(
  EXPORTING
    tipodeconta = 'CP'
    nome        = 'Vov�'
).

"Escreve o m�todo status e saldo do objeto
write: o_novaconta2->get_status(  ),
       o_novaconta2->get_saldo(  ),
       o_novaconta2->get_dono(  ),
       o_novaconta2->get_numconta(  ).