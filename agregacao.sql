use restaurante;

select * from clientes;
select * from funcionarios;
select * from info_produtos;
select * from pedidos;
select * from produtos;

select count(*) from pedidos; -- Quantidade de pedidos realizados
select count(distinct id_cliente) from pedidos;

select avg(preco) from produtos; -- Media de preço dos produtos
select max(preco) from produtos; -- Preço produto mais caro
select min(preco) from produtos; -- Preço produto mais barato

select nome, preco, row_number() over (order by preco desc) as ranking_preco from produtos limit 5; -- Ranking dos 5 pratos mais caros do restaurante

select categoria, round(avg(preco),2) as media_preco from produtos group by categoria; -- Media de preço de cada categoria de prato do restaurante

select fornecedor, count(*) as produto from info_produtos group by fornecedor; -- Mostra quantos produtos cada fornecedor fornece 
select fornecedor, count(*) as produto from info_produtos group by fornecedor having count(*) > 1; -- Mostra quais forncedores fornecem mais de um produto;

select id_cliente, count(*) as quantidade_pedido from pedidos group by id_cliente having count(*) = 1; -- Mostra quais clientes fizeram apenas um pedido



