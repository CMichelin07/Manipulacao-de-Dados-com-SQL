use restaurante;

select * from clientes;
select * from funcionarios;
select * from info_produtos;
select * from pedidos;
select * from produtos;

-- c = clientes / f = funcionarios / ip = info_produtos / pe = pedidos / pr = produtos 

select pr.id_produto, pr.nome as produto, pr.descricao, ip.ingredientes
from produtos pr
inner join info_produtos ip
on pr.id_produto = ip.id_produto;  -- Retorna os produtos e seus ingredientes

select pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome as cliente, c.email
from pedidos pe 
join clientes c 
on pe.id_cliente = c.id_cliente; -- Retorna os clientes e a quantidade de pedidos

select pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome as cliente, c.email, f.nome as funcionario
from pedidos pe 
join clientes c 
on pe.id_cliente = c.id_cliente
join funcionarios f
on pe.id_funcionario = f.id_funcionario; -- Retorna clientes, quantidade de pedidos e o funcionário que atendeu

select pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome as cliente, c.email, f.nome as funcionario, pr.nome as produto, pr.preco
from pedidos pe 
join clientes c on pe.id_cliente = c.id_cliente
join funcionarios f on pe.id_funcionario = f.id_funcionario
join produtos pr on pe.id_produto = pr.id_produto; -- Retorna cliente, quantidade de pedidos, data, funcionario que atendeu e o valor do pedido

select c.nome as cliente, pe.status_pedido 
from pedidos pe
join clientes c on c.id_cliente = pe.id_cliente 
where status_pedido = "Pendente"
order by pe.status_pedido desc; -- Retorna os clientes com pedido pendente

select c.*
from clientes c
left join pedidos pe on c.id_cliente = pe.id_cliente
where pe.id_pedido is null; -- Retorna os clientes que não realizaram pedidos

select nome,
	(select count(*) from pedidos where pedidos.id_cliente = clientes.id_cliente) as total_pedidos
from clientes
order by total_pedidos desc; -- Retorna o numero total de pedidos realizados por cada cliente 

select pe.id_pedido, pe.quantidade,
	sum(pe.quantidade * pr.preco) as preco_total
    from pedidos pe
    join produtos pr on pe.id_produto = pr.id_produto 
    group by pe.id_pedido, pe.quantidade
    order by id_pedido asc; -- Retorna o total gasto em cada pedido

