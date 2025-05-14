/*Condicional*/ 

use informatica;

-- Filtar por campo numérico
select nome, limite_credito from cliente where limite_credito <= 5500;

-- Filtrar campos por texto
select nome, limite_credito from cliente where nome = "João";
select nome, limite_credito from cliente where nome like "Jo%";

-- Filtrar por campo boleano
select nome, email from cliente where cadastro_ativo = true; -- 0 false, 1 true

-- Filtrar por campo data
select nome, data_nascimento from cliente where data_nascimento > "1990-01-01"; -- AA-MM-DD
select nome, data_nascimento from cliente where year(data_nascimento) > 1990; -- year, month, day

select * from cliente;

/*Ordenação*/

-- Ordenar por ordem alfabética
select nome from cliente order by nome;

-- Ordenar por ordem decrescente
select nome, data_nascimento from cliente order by data_nascimento desc;

-- Ordenar por mais de um campo
select nome, limite_credito from cliente order by limite_credito asc, nome desc;

-- Limitação

-- Selecionar um registro (Boa prática)
select * from cliente limit 1;

-- Selecionar os 3 clientes com mais limites de crédito
select nome, limite_credito from cliente order by limite_credito desc limit 3;

-- Pular os 3 primeiros registros e selecionar os próximos 2:
select nome from cliente order by nome limit 2 offset 3;