/* Consultando dados */

use informatica;
desc cliente;

truncate cliente;

insert into cliente
values (null, "Marcos", "marcos@email.com", "1991-01-05", 8000.00, Null, True, 2),
	   (null, "Carol", "carol@email.com", "1998-02-26", 5500.00, Null, True, 1),
       (null, "Ana", "ana@email.com", "1980-05-28", 10000.00, "Revisão de cadastro", True, 1),
       (null, "João", "joao@email.com", "1995-10-14", 5500.00, "Inativo", False, Null),
       (null, "Thiago", "thiago@email.com", "2001-08-20", 4600, Null, True, 1);

-- Selecionar todas as colunas de uma tabela
select * from cliente;

-- Selecionar colunas específicas
select nome, email from cliente;

-- Criar Tabela a partir da seleção de dados (Backup*)
create table backup_cliente as select * from cliente;

desc cliente;
desc backup_cliente;

-- Inserir registros a partir da seleção de dados ()
truncate backup_cliente;
select * from backup_cliente;
insert into backup_cliente select * from cliente;
select * from backup_cliente;

select * from cliente;



