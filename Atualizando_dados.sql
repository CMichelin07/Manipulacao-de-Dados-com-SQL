/* Atualizando Dados*/ 

use informatica;

-- Selecionar tabela
select * from cliente;
desc cliente;

-- Atualizar 1 campo
update cliente 
set email = "marcos_novo@email.com"
where id_cliente = 1;

-- Atualizar multiplos campos
update cliente
set data_nascimento = "1975-04-10", limite_credito = "1000.00"
where id_cliente = 2;

-- Atualizar com operadores matemáticos
update cliente
set limite_credito = limite_credito + 500
where id_cliente = 3;

-- Atualizar com condiçoes complexas
update cliente 
set cadastro_ativo = false
where limite_credito <= 1000 and data_nascimento < "1980-01-01";

set sql_safe_updates = 1;

-- Atualizar todos os registros de uma coluna
update cliente
set info_adicionais = "Revisão de cadastro";
