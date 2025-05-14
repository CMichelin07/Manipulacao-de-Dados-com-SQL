/* Consulta multipla tabelas -- JOIN */ 

use loja_informatica;

select * from cliente;
select * from pedido;
select * from produto;

-- Inner Join entre cliente e pedido
select cliente.nome, cliente.email, pedido.id_pedido
from cliente
inner join pedido
on cliente.id_cliente = pedido.id_cliente;

-- Inner Join entre pedido e produto
select pedido.id_pedido, produto.nome_produto, produto.preco, pedido.quantidade
from pedido
inner join produto
on pedido.id_produto = produto.id_produto;

-- Inner Join entre cliente, pedido e produto
select cliente.nome as cliente, produto.nome_produto as produto, produto.preco, pedido.quantidade, pedido.data
from cliente
inner join pedido on cliente.id_cliente = pedido.id_cliente
inner join produto on pedido.id_produto = produto.id_produto;

-- Alias para tabelas
select c.nome as cliente, p.nome_produto as produto, p.preco, pe.quantidade, pe.data
from cliente c
inner join pedido pe on c.id_cliente = pe.id_cliente
inner join produto p on pe.id_produto = p.id_produto;

-- 
select c.nome as cliente, p.nome_produto as produto, p.preco, pe.quantidade, pe.data
from cliente c
inner join pedido pe on c.id_cliente = pe.id_cliente
inner join produto p on pe.id_produto = p.id_produto
where p.preco > 1000
group by p.nome_produto, c.nome, p.preco, pe.quantidade, pe.data
order by p.preco desc;

-- Outer Join

select * from cliente;
select * from pedido;
select * from produto;

-- Inner Join: Visualizar clientes com pedidos
select c.nome, pe.id_pedido
from cliente c
inner join pedido pe on c.id_cliente = pe.id_cliente;

-- Left Outer Join: Visualizar todos os clientes, incluindo aqueles sem pedidos
select c.nome, pe.id_pedido
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente;

-- Right Outer Join: Visualizar todos os pedidos, incluindo aqueles sem clientes
select c.nome, pe.id_pedido
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente;

-- Left Outer Join: Visualizar clientes sem pedidos
select c.*
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
where pe.id_pedido is null;

-- Left Outer Join: Visualizar todos os clientes, com seus pedidos e produtos, incluindo aqueles sem pedidos e produtos
select c.nome, pe.id_pedido, p.nome_produto as produto
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto p on pe.id_produto = p.id_produto;

-- Calculo total gasto por cada cliente em seus pedidos
select c.nome, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
inner join pedido pe on c.id_cliente = pe.id_cliente
inner join produto p on pe.id_produto = p.id_produto
group by c.nome;

-- Visualiza quais clientes não gastaram em seus pedidos (erro)
select c.nome, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto p on pe.id_produto = p.id_produto
where p.preco is null
group by c.nome;

-- FULL JOIN, SOFT JOIN E NATURAL JOIN

-- Revisão
select * from cliente;
select * from pedido;
select * from produto;

-- LEFT JOIN
select c.nome, pe.id_pedido
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente;

-- RIGHT JOIN
select c.nome, pe.id_pedido
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente;

-- FULL JOIN
select c.nome, pe.id_pedido
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
where pe.id_pedido is null
union
select c.nome, pe.id_pedido
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente
where c.id_cliente is null;

select c.nome as cliente, p.nome_produto as produto, pe.quantidade
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto p on pe.id_produto = p.id_produto
union
select c.nome as cliente, p.nome_produto as produto, pe.quantidade
from cliente c
right join pedido pe on c.id_cliente = pe.id_cliente
right join produto p on pe.id_produto = p.id_produto;

-- Natural Join

select *
from pedido
natural join produto; -- Não recomendado

-- SELF JOIN

-- Compara clientes dentro da mesma cidade, excluindo comparações com o mesmo cliente
select
	c1.nome as Cliente1,
    c2.nome as Cliente2,
    c1.cidade as CidadeComum
from
	cliente c1
join
	cliente c2 on c1.cidade = c2.cidade and c1.id_cliente != c2.id_cliente
order by
	c1.cidade, c1.nome, c2.nome;
    
    -- Subconsultas
    
select * from cliente;
select * from pedido;
select * from produto;

-- Subconsulta WHERE
select nome
from cliente
where id_cliente in (select id_cliente from pedido); -- Clientes que tenham feitos pedidos

select distinct c.nome
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente; -- Clientes tenham feitos pedidos *2 (sem repetir nomes)

select nome, email
from cliente
where id_cliente in (select id_cliente from pedido where quantidade > 5); -- Clientes que tenham feito mais de 5 pedidos

-- Subconsultas SELECT 
select nome,
	(select count(*) from pedido where pedido.id_cliente = cliente.id_cliente) as total_pedidos
from cliente; -- Busca a quantidade total de pedidos de cada cliente

select c.nome, c.email,
	(select sum(pe.quantidade * pr.preco)
    from pedido pe
    join produto pr on pe.id_produto = pr.id_produto
    where pe.id_cliente = c.id_cliente) as total_pedido
from cliente c order by total_pedido desc; -- Retorna o total gasto por cada cliente 

-- Subconsulta HAVING 
select categoria, avg(preco) as media_preco
from produto 
group by categoria 
having avg(preco) > (select avg(preco) from produto); -- Retorna a media de preço dos produtos de cada categoria com uma media de preço acima do geral

-- Subsonculta FROM
select cl.nome, pedidos_agregados.total_pedidos, pedidos_agregados.soma_quantidade
from cliente cl
join (
	select id_cliente, count(*) as total_pedidos, sum(quantidade) as soma_quantidade
    from pedido
    group by id_cliente 
) as pedidos_agregados on cl.id_cliente = pedidos_agregados.id_cliente; -- Retorna o total de pedidos e a quantidade de itens comprado de cada cliente

-- Subsconsulta ORDER BY
select c.nome, c.email
from cliente c
order by (
	select sum(pe.quantidade * pr.preco)
    from pedido pe join produto pr on pe.id_produto = pr.id_produto where pe.id_cliente = c.id_cliente
    ) desc; -- Ordena clientes pelo total de compras realizadas em valores gastos
    
    