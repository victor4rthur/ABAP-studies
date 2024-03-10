*&---------------------------------------------------------------------*
*& Report zad_testeconta
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zad_testeconta.

"Criar um novo objeto do tipo da classe com os construtores necessários
DATA(o_novaconta)  = new zadcl_bank_account(
    i_const_saldo  = 0
    i_const_status = abap_false
).

"O objeto criado usa o método abrir conta com os construtores necessários
o_novaconta->zad_i_bank~abrirconta(
  EXPORTING
    tipodeconta = 'CC'
    nome        = 'Vovô'
).

"Escreve o método status e saldo do objeto
write: o_novaconta->get_status(  ),
       o_novaconta->get_saldo(  ),
       o_novaconta->get_dono(  ),
       o_novaconta->get_numconta(  ).

**********************************************************************

"Criar um novo objeto do tipo da classe com os construtores necessários
DATA(o_novaconta2)  = new zadcl_bank_account(
    i_const_saldo  = 0
    i_const_status = abap_false
).

"O objeto criado usa o método abrir conta com os construtores necessários
o_novaconta2->zad_i_bank~abrirconta(
  EXPORTING
    tipodeconta = 'CP'
    nome        = 'Vovó'
).

"Escreve o método status e saldo do objeto
write: o_novaconta2->get_status(  ),
       o_novaconta2->get_saldo(  ),
       o_novaconta2->get_dono(  ),
       o_novaconta2->get_numconta(  ).