/* Aula 2 */

use informatica;

create table cliente(
	id_cliente int auto_increment primary key,
    nome varchar(255) not null,
    email varchar(100),
    data_nascimento date,
    limite_credito decimal(10, 2),
    info_adicionais text,
    cadastro_ativo boolean default 1,
    id_produto int,
    unique (email)
) comment= "Tabela de clientes de informática";

describe cliente;
drop table cliente;

-- Selecionar tabela
select * from cliente;

-- Inserir 1 registro
insert into cliente (nome, email, data_nascimento, limite_credito) values
					("Marcos", "marcos@email.com", "1991-01-05", 8000.00);
                    
insert into cliente (nome) value
					("Pedro");
                    
-- Inserir multiplos registros 
insert into cliente (nome, email, data_nascimento, limite_credito) values
					("Ana", "ana@email.com", "1980-05-28", 10000.00),
                    ("Joao", "joao@email.com", "1995-10-14", 5500.00);
                    
-- Inserir registro sem especificar os campos (No caso é necessário preencher todos os campos)
insert into cliente values (null, "Thiago", "thiago@email.com", "1995-08-20", 4600, null, true, 1);