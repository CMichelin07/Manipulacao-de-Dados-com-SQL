use restaurante;

select * from clientes;
select * from funcionarios;
select * from info_produtos;
select * from pedidos;
select * from produtos;

-- c = clientes / f = funcionarios / ip = info_produtos / pe = pedidos / pr = produtos 

create view resumo_pedido as
select pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome, c.email, f.nome as funcionario, pr.nome as nome_produto, pr.preco
from clientes c 
join pedidos pe on c.id_cliente = pe.id_cliente
join produtos pr on pr.id_produto = pe.id_produto
join funcionarios f on f.id_funcionario = pe.id_funcionario; -- Cria uma view que retorna os dados dos pedidos realizados 

select id_pedido, nome, quantidade * preco as total_pedido from resumo_pedido;

drop view resumo_pedido;

create view resumo_pedido as
select pe.id_pedido, pe.quantidade, pe.data_pedido, c.nome as cliente, c.email, f.nome as funcionario, pr.nome as nome_produto, pr.preco, (pe.quantidade * pr.preco) as total
from clientes c 
join pedidos pe on c.id_cliente = pe.id_cliente
join produtos pr on pr.id_produto = pe.id_produto
join funcionarios f on f.id_funcionario = pe.id_funcionario; -- Cria uma view que retornar os dados dos pedidos realizados agora com o campo total já incluído

select id_pedido, cliente, total from resumo_pedido;

explain
select id_pedido, cliente, total from resumo_pedido;

DELIMITER //
create function BuscaIngredientesProdutos (idProduto int)
returns varchar (200)
reads sql data
begin
	declare ingProdutos varchar (200);
    select ingredientes into ingProdutos from info_produtos where id_produto = idProduto;
    return ingProdutos;
end //
DELIMITER ; -- Função para retornar os ingredientes com base no id do produto

select BuscaIngredientesProdutos(10); -- Faz a consulta da funcao

DELIMITER //
create function mediaPedido (idPedido int)
returns varchar (100)
reads sql data
begin
	declare totalPedidos decimal (10, 2);
    declare mediaTotal decimal (10, 2);
    declare resultado varchar (100);
    
    select coalesce(sum(pr.preco * pe.quantidade), 0) into totalPedidos
	from pedidos pe
    left join produtos pr on pr.id_produto = pe.id_produto
    where pr.id_produto = idPedido;
    
    select coalesce(avg(total_pedido),0) into mediaTotal
    from (select sum(pr.preco* pe.quantidade) as total_pedido
		from pedidos pe
		left join produtos pr on pr.id_produto = pe.id_produto
		group by pe.id_pedido) as media;
    
    set resultado =
	case
		when totalPedidos > mediaTotal then "Acima da média"
        when totalPedidos < mediaTotal then "Abaixo da média"
        when totalPedidos = 0 then "Cliente não realizou pedido"
        else "Pedido está dentro da média" 
	end;
return resultado;

end // -- Funcao criada para saber se o pedido realizado está acima, dentro ou abaixo da media do restaurante 
DELIMITER ;

select mediaPedido(5);
select mediaPedido(6);








