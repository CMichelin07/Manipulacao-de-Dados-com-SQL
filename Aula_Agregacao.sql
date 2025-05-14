/* Agregações */

-- Preparação do BD 

create database loja_informatica;

use loja_informatica;

select * from backup_cliente limit 10;
select * from backup_pedido limit 10;
select * from backup_produto limit 10;

create table if not exists cliente (
	id_cliente int primary key,
    nome varchar (200),
    email varchar (100),
    cidade varchar (100)
);

create table if not exists produto (
	id_produto int primary key,
    nome_produto varchar (200),
    categoria varchar (100),
    preco decimal (10, 2)
);

create table if not exists pedido (
	id_pedido int primary key,
    id_cliente int,
    id_produto int,
    quantidade int,
    data DATE,
    foreign key (id_produto) references produto(id_produto),
    foreign key (id_cliente) references cliente(id_cliente) 
);

insert into cliente select * from backup_cliente;
insert into produto select * from backup_produto;
insert into pedido select * from backup_pedido; -- Errado
insert into pedido select id_pedido, id_cliente, id_produto, quantidade, str_to_date(data, "%d/%m/%Y") from backup_pedido; 


select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 10;

-- Funções de Agregação

select count(*) from pedido;
select count(quantidade) from pedido;
select count(id_pedido) from pedido;
select count(distinct id_cliente) from pedido;

select sum(quantidade) from pedido;
select avg(quantidade) from pedido;

select MAX(preco) from produto;
select min(preco) from produto;

select var_pop(preco) from produto; -- Variancia populacionar = VARIANCE()
select var_samp(preco) from produto; -- Variancia amostral

select stddev(preco) from produto; -- Desvio padrão = STDDEV_POP; Desvio padrão amostral STDDEV_SAMP

select group_concat(distinct quantidade) from pedido;

select nome_produto, preco, rank() over (order by preco desc) as ranking_preco from produto; -- rankeia os produtos
select nome_produto, preco, row_number() over (order by preco desc) as ranking_preco from produto; -- rankeia os produtos seguindo uma sequencia 1,2,3...
select nome_produto, preco, dense_rank() over (order by preco desc) as ranking_preco from produto; -- rankeia os produtos deixando os iguais como 1 e assim sussecivamente
select distinct nome_produto, preco, dense_rank() over (order by preco desc) as ranking_preco from produto; -- rankeia mostrando apenas um produto 
select distinct nome_produto, preco, dense_rank() over (order by preco desc) as ranking_preco from produto limit 5; -- limita o ranking em 5

-- Agrupando Resultados

select * from cliente;
select * from pedido;
select * from produto;

select sum(preco) as preco_total from produto;
select sum(preco) as preco_total from produto group by categoria;
select categoria, sum(preco) as preco_total from produto group by categoria;
select categoria, nome_produto, sum(preco) as preco_total from produto group by categoria, nome_produto order by categoria, nome_produto;

select categoria, avg(preco) as media_preco from produto group by categoria;
select categoria, round(avg(preco),2) as media_preco from produto group by categoria order by categoria;

select
	distinct categoria,
	preco,
    dense_rank() over (order by preco desc) as ranking_preco
from
	produto; -- Trocar categoria

select 
	categoria,
    sum(preco) as preco_total,
    rank() over (order by sum(preco) desc) as ranking_preco
from
	produto
group by
	categoria;
    
-- Filtrando Agregações 

select * from cliente limit 10;
select * from pedido limit 20;
select * from produto limit 10;

select categoria, count(*) from produto group by categoria;
select categoria, count(*) from produto group by categoria having count(*) > 10;

select categoria, count(*) from produto where categoria <> "acessorios" group by categoria;

select categoria, count(*) from produto where categoria <> "acessorios" group by categoria having count(*) > 10;
select categoria, count(*) from produto group by categoria having count(*) > 10 and categoria <> "acessorios"; 

-- Resolução de problema:
-- Identificar quais produtos foram vendidos mais de uma vez com erro (quantidade = 0)

select * from pedido;

select * from pedido where quantidade is null;
select id_produto, count(id_produto) from pedido where quantidade is null group by id_produto;
select id_produto, count(id_produto) from pedido where quantidade is null group by id_produto having count(id_produto) > 1;










