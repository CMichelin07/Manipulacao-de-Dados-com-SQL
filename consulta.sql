use restaurante;
desc produtos;

select * from produtos;
select nome, categoria from produtos where preco > 30;

select * from clientes;
select nome, telefone, data_nascimento from clientes where year (data_nascimento) < "1985";

desc info_produtos;
select * from info_produtos;
select id_produto, ingredientes from info_produtos where ingredientes like "%carne%";

select * from produtos;
select nome, categoria from produtos order by categoria, nome;
select nome, preco from produtos order by preco desc limit 5;
select nome, categoria from produtos where categoria = "Prato Principal" limit 2 offset 6;

create table backup_pedidos as select * from pedidos;
select * from backup_pedidos;
 
