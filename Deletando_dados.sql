/* Deletando Dados */

use informatica;

select * from cliente;

-- Deletar 1 registro
delete from cliente
where id_cliente = 4;

-- Deletar registros com condições multiplas
delete from cliente
where cadastro_ativo = false and limite_credito < 2000;

-- Deletar todos os registros
delete from cliente; -- Tem os registros da linha

truncate table cliente; -- Não permite recuperar os dados

set sql_safe_updates = 0;
