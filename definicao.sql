/* Projeto EBAC - Restaurante*/ 

create database restaurante;
use restaurante;
create table funcionarios(
	id_funcionario int auto_increment primary key,
    nome varchar(255), -- Nome Completo do Funcionário
    cpf varchar(14), -- Cpf do Funcionário
    data_nascimento date, -- Data de Nascimento do Funcionário
    endereco varchar(255), -- Endereço Residencial do Funcionário
    telefone varchar(15), -- Telefone do Funcionário
    email varchar (100), -- Email do Funcionário
    cargo varchar(100), -- Cargo do Funcionário
    salario decimal(10, 2), -- Salário do Funcionário
    data_admissao date -- Data de admissão do Funcionário
);
describe funcionarios;
drop table funcionarios;

create table clientes(
	id_cliente int auto_increment primary key,
    nome varchar(255), 
    cpf varchar(14),
    data_nascimento date,
    endereco varchar(255),
    telefone varchar(15),
    email varchar(100),
    data_cadastro date
);
describe clientes;

create table produtos(
	id_produto int auto_increment primary key,
    nome varchar(255),
    descricao text, -- Descrição detalhada do produto
    preco decimal (10, 2),
    categoria varchar(100) -- Categoria do Produto [Bebida, Sobremesa, Prato principal...]
);
describe produtos;

create table pedidos(
	id_pedido int auto_increment primary key,
    id_cliente int,
    foreign key (id_cliente) references clientes(id_cliente), -- Referencia ao cliente que fez o pedido
    id_funcionario int,
    foreign key (id_funcionario) references funcionarios(id_funcionario), -- Referencia ao Funcionario que gerou o pedido
    id_produto int,
    foreign key (id_produto) references produtos(id_produto), -- Referencia ao produto escolhido
    quantidade int,
    preco decimal(10, 2),
    data_pedido date,
    status_pedido varchar(50)
);
describe pedidos;

create table info_produtos(
	id_info int auto_increment primary key,
    id_produto int,
    foreign key (id_produto) references produtos(id_produto),
	ingredientes text,
    fornecedor varchar(255)
);
describe info_produtos;


