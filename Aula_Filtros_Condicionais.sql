/* Filtros Condicionais */ 

use informatica;

-- AND, OR e NOT 

select * from cliente;

select * from cliente
where cadastro_ativo = true and limite_credito > 6000; -- Busca os cadastros ativos com limite de credito maior que R$6000,00

select * from cliente
where cadastro_ativo = true or limite_credito > 6000; -- Busca os cadastros ativos ou com credito maior que R$6000,00

select * from cliente
where limite_credito > 6000 and year(data_nascimento) > 1980; -- Busca os cadastros com limite de credito maior que R$6000,00 e que nasceram depois de 1980

select * from cliente 
where cadastro_ativo = true or limite_credito > 6000 and year(data_nascimento) > 1980; -- Buscar se o cadastro está ativo ou o limmite de credito maior que R$6000,00 e nascimento depois de 1980

select * from cliente 
where (cadastro_ativo = true or limite_credito > 6000) and year(data_nascimento) > 1980; -- Busca primeiro se o cadastro está ativo ou o limite de credito é maior que R$6000,00

select * from cliente
where not limite_credito > 6000; 


-- IN 

select * from cliente;

select * from cliente where id_cliente in (1, 2, 4, 6);

select * from cliente where year(data_nascimento) in (1991, 1995);

-- BETWEEN

select * from cliente;

select * from cliente where data_nascimento between "1990-01-01" and "2000-12-31";

select * from cliente where limite_credito between 6000 and 10000;

-- LIKE

select * from cliente;

select * from cliente where info_adicionais like "revisão%"; 

select * from cliente where info_adicionais like "%cadastro"; -- Custoso computacional

select * from cliente where email like "%@%.com";

insert into cliente (nome, email, data_nascimento, info_adicionais)
			values  ("A", "a@a.com", "1990-10-10", " "); -- Cadastro incorreto

select * from cliente where not email like "__%@__%.com"; -- USAR NOT

select * from cliente where email like "___%@email.com";
select * from cliente where email like "__%@_mail.com" or email like "__%@__mail.com";

select * from cliente 
where (nome like "a%" or nome like "b%" or nome like "c%") and cadastro_ativo = true;


/* NULL e NOT NULL */

select * from cliente;

select * from cliente where info_adicionais is null;
select * from cliente where info_adicionais is not null;

select * from cliente
where limite_credito > 5000 and (info_adicionais is null or id_produto is null);

select nome, limite_credito, ifnull(limite_credito, 0) as limite_credito_tratado from cliente;

select nome, info_adicionais, ifnull(info_adicionais, "Nada Consta") as info_adicionais_tratada from cliente;

select nome, info_adicionais, nullif(info_adicionais, "Inativo") as info_adiocionais_tratada from cliente;

select nome, info_adicionais, nullif(info_adicionais, " ") as info_adicionais_tratada from cliente;

select nome, info_adicionais, ifnull(nullif(info_adicionais, " "), "Nada Consta") as info_adicionais from cliente;

select nome, coalesce(info_adicionais, "Nada Consta") from cliente;

select nome, coalesce(email, info_adicionais, limite_credito, id_produto, "Cadastro Nulo") from cliente;

select nome, info_adicionais, coalesce(info_adicionais, "Não Consta") as info from cliente;

-- Tratar em espaços branco

select "      Remover espaços    " , trim("    Remover Espaços    "); 

select nome, info_adicionais from cliente where info_adicionais <> trim(info_adicionais);

select * from cliente
where nullif(trim(info_adicionais), " ") is null;

select * from cliente
where nullif(info_adicionais, " ") is null;

-- IF e CASE

select * from cliente;

select nome, limite_credito, if(limite_credito > 6000, "Alto", "Baixo") as categoria_limite from cliente;

select 
	nome,
    limite_credito,
    case
		when limite_credito > 6000 then "Alto"
        else "Baixo"
	end as categoria_limite
from cliente;

select id_cliente, nome, limite_credito,
	if(limite_credito > 9000, "Premium", if(limite_credito between 5000 and 9000, "Gold", "Baixo"))
    as categoria_limite from cliente;
    
    select id_cliente, nome, limite_credito,
		case
			when limite_credito > 9000 then "Premium"
            when limite_credito between 5000 and 9000 then "Gold"
            else "Silver" 
		end as categoria_cliente
	from cliente;
    
    
        





         



  