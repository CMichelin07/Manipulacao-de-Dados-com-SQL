/* Aula 3 - Alteração e Exclusão */

use informatica;

show create table cliente;

describe cliente;

-- Alterações básicas de adição e remoção de coluna
alter table cliente add column endereço varchar(255);
alter table cliente add column cidade varchar(255);
alter table cliente drop column endereço;

-- Alterações de coluna existente
alter table cliente modify nome varchar(150);
alter table cliente change nome nome_completo varchar(255);
alter table cliente alter cidade set default "Não informado";

-- Alterações de chave [cuidado]
alter table cliente modify id_cliente int;
alter table cliente drop primary key;
alter table cliente add primary key (id_cliente);

create table produto (id_produto int primary key);
alter table cliente add foreign key (id_produto) references produto(id_produto);

-- Renomear tabela
alter table cliente rename to clientes_antigos;

-- Exclusão de Tabela
drop table if exists clientes_antigos;