/* Consultas Avançadas */

use loja_informatica;

select * from cliente limit 10;
select * from produto limit 10;
select * from pedido limit 20;

-- View para simplifcar a tabela cliente
create view cliente_simples as
select id_Cliente, nome, email
from cliente;

-- Consultar view
select * from cliente_simples limit 10;

-- Visualizar estrutra da View
show create view cliente_simples;
desc cliente_simples;

-- Manipular dados iguais tabelas (update, insert e delete)

-- Atualizar View
create or replace view cliente_simples as
select id_cliente, nome, cidade
from cliente;

select * from cliente_simples limit 10;

-- Deletar view
drop view cliente_simples;

-- View para calcular o total de pedidos feitos por cada cliente
create view cliente_pedido_total as 
select c.nome, count(pe.id_pedido) as total_pedidos
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
group by c.nome;

select * from cliente_pedido_total where total_pedidos > 15;

-- View para listar detalhes do cliente e total gasto
create view cliente_gasto_total as
select c.nome, c.email, sum(p.preco * pe.quantidade) as total_gasto
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente 
join produto p on pe.id_produto = p.id_produto
group by c.nome, c.email;

select * from cliente_gasto_total where total_gasto > 500;

-- Procedimento armazenado para listar todos os clientes
create procedure ListarCLientes()
	select * from cliente;
    
-- Chamar o procedimento armazenado
call ListarClientes();

-- Procedimento armazenado para inserir um novo pedido
DELIMITER //
create procedure AdicionarPedido(In pedidoID int, in  clienteID int, in produtoID int, in qtd int, in dataPedido date)
begin
	insert into pedido(id_pedido, id_cliente, id_produto, quantidade, data) values (pedidoID, clienteID, produtoID, qtd, dataPedido);
    insert into backup_pedido(id_pedido, id_cliente, id_produto, quantidade, data) values (pedidoID, clienteID, produtoID, qtd, dataPedido);
end //
DELIMITER ;

call AdicionarPedido(201, 1, 2, 10, "2024-03-01");

select * from pedido where id_pedido = 201;
select * from backup_pedido where id_pedido = 201;

-- Procedimento armazenado para visualizar novos preços sem alterar a tabela produto e visualizar a quantidade de registros
DELIMITER //
Create procedure PromocaoProdutos(In desconto float, out totalProdutos int)
begin
	declare fator_desconto float;
    set fator_desconto = (1 - (desconto/100));
    
    select count(*) into totalProdutos
    from produto;
    
    select id_produto, nome_produto, preco as preco_original, round(preco * fator_desconto, 2) as preco_com_desconto
    from produto;
end //
DELIMITER ;

CALL PromocaoProdutos (5, @totalProdutos);
select @totalProdutos as produtos_totais_alterados;

-- Mostrar todos os procedimentos
show procedure status;

-- Deletar procedimento
drop procedure if exists AdicionarPedido;

/* Funções */

-- Função para retornar o nome de um cliente com base no seu ID
DELIMITER //
create function BuscaClienteNome(idCliente int)
returns varchar (200)
reads sql data 
begin
	declare nomeCliente varchar (200);
    select nome into nomeCliente from cliente where id_cliente = idCliente;
    return nomeCliente;
end //
DELIMITER ;

-- Usar a função em consulta
select BuscaClienteNome(76);

-- Função para calcular o total de vendas de um produto
DELIMITER //
create function TotalVendas(produtoID int)
returns decimal	(10, 2)
reads sql data
begin
	declare total decimal (10,2);
    select sum(preco * quantidade) into total 
    from pedido
    join produto on produto.id_produto = pedido.id_produto
    where produto.id_produto = produtoID;
    return total;
end //
DELIMITER ;

select nome_produto, TotalVendas(id_produto)as total_vendas from produto;

-- Função para classificar o desempenho de vendas de um produto
DELIMITER //
create function ClassificaDesempenhoVendas(produtoID int)
returns varchar (100)
reads sql data
begin
	declare totalVendas decimal (10, 2);
    declare desempenho varchar (100);
    
    select coalesce(sum(p.preco * pe.quantidade), 0) into totalVendas
    from produto p
    left join pedido pe on p.id_produto = pe.id_produto
    where p.id_produto = produtoID;
    
    set desempenho =
    case 
		when totalVendas = 0 then "Sem Vendas"
        when totalVendas <= 1000 then "Baixo"
        when totalVendas <= 5000 then "Médio"
        else "Alto"
	end;
    
	return desempenho;
end //
    DELIMITER ;
    
    select nome_produto, ClassificaDesempenhoVendas(id_produto) as desempenho_vendas from produto;

-- Função para calcular desconto em cima de um valor de produto 
DELIMITER //
create function CalculaDesconto (valor decimal (10, 2), percentualDesconto decimal (5, 2))
returns decimal (10, 2)
no sql
begin
	declare resultado decimal (10, 2);
    set resultado = valor - (valor * (percentualDesconto / 100));
    return resultado;
    end //
    DELIMITER ;
    
    select CalculaDesconto (150.00, 5) as ValorComDesconto;
    
    -- Mostrar todas as funções
    show function status;
    
    -- Deletar função
    drop function "nome da função";
    
    /* Boas Práticas */ 
    
-- Utilizar Alias simples e facil de entender 
select pe.id_pedido, c.nome as nome_cliente, p.nome_produto, round(coalesce(pe.quantidade * p.preco, 0),2) as valor_total
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente
join produto p on pe.id_produto = p.id_produto;

-- Evitar o uso de Select *
select nome, email from cliente;
select c.nome, c.email
	from cliente c;
    
-- Usar EXPLAIN para otimizar consultas e indices 
explain
select c.nome, c.email,
	(select sum(pe.quantidade * pr.preco)
    from pedido pe
    join produto pr on pe.id_produto = pr.id_produto
    where pe.id_cliente = c.id_cliente) as total_pedido
from cliente c
order by total_pedido desc;

explain
select c.nome, c.email, sum(pe.quantidade * pr.preco) as total_pedido
from cliente c
left join pedido pe on c.id_cliente = pe.id_cliente
left join produto pr on pr.id_produto = pe.id_produto
group by c.id_cliente, c.nome, c.email
order by total_pedido desc;

explain
select c.nome, c.email, sum(pe.quantidade * pr.preco) as total_pedido
from cliente c
join pedido pe on c.id_cliente = pe.id_cliente
join produto pr on pr.id_produto = pe.id_produto
group by c.id_cliente, c.nome, c.email
order by total_pedido desc;

create index idx_pedido_produto on pedido(id_produto); -- Criação de indice
drop index idx_pedido_produto on pedido; -- Deletar indice

-- Evitar funções em coluna no where
select * from pedido where month(data) = 1; -- Ineficiente

select * from pedido where data between "2023-01-01" and "2023-01-31"; -- Eficiente
	
-- Uso de transações para garantir integridade e a confiabilidade nos dados

-- Inicar transação
start transaction;

insert into cliente(id_cliente, nome, email, cidade) values (101, "Rodrigo Augusto", "rodrigo.augusto@email.com", "São Jose dos Campos");
insert into pedido (id_pedido, id_cliente, id_produto, quantidade, data) values (203, 101, 7, 3, "2023-11-27");

-- Confirmar as operações
commit;
-- Reverter as operações
rollback;

select * from cliente where id_cliente = "101";
select * from pedido where id_pedido = "203";





