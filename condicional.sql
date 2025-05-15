use restaurante;

select * from pedidos;

select * from pedidos
where id_funcionario = 4 and status_pedido = "Pendente";

select * from pedidos
where status_pedido <> "Concluído";

select * from pedidos
where id_produto in (1, 3, 5, 7 or 8);
--

select * from clientes;

select * from clientes
where nome like "C%";
--

select * from produtos;

select * from produtos
where descricao like "%carne%" or descricao like "%frango%";

select * from produtos
where preco between 20 and 30;
--

update pedidos
set status_pedido = null
where id_pedido = 6;

select * from pedidos
where status_pedido is null;

select id_pedido, status_pedido, ifnull(status_pedido, "Cancelado") as status_pedido_atualizado from pedidos;
--

select * from funcionarios;

select
	nome, cargo, salario,
		case
			when salario > 3000 then "Acima da Média"
            else "Abaixo da Média"
		end as media_salario
	from funcionarios;
		
