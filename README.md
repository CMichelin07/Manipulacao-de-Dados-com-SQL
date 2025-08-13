# Manipulação de Dados com SQL

Projeto desenvolvido como parte do curso de **Analista de Dados** da EBAC, focado em técnicas de **manipulação e consulta de dados utilizando SQL** em conjuntos de dados fictícios.

## 📌 Objetivo
Este projeto teve como principal propósito exercitar o uso de SQL para manipulação de dados em diferentes contextos, com foco em:

- Definição dos dados e sua estrutura (`definicao.sql`).
- Consultas básicas para seleção e filtragem (`consulta.sql`).
- Uso de condicionais e lógica aplicada (`condicional.sql`).
- Agregação de dados e cálculo de estatísticas (`agregacao.sql`).
- Consultas mais complexas e refinadas (`consultas_avancadas.sql`).
- Operações combinadas entre múltiplas tabelas (`multiplas_tabelas.sql`).
- Técnicas de manipulação mais amplas (`manipulacao.sql`).

## 📂 Estrutura do Repositório
```
Projeto_SQL_EBAC/                   # Branch principal contendo este projeto
├── definicao.sql                 # Criação/definição das tabelas e dados
├── consulta.sql                  # Consultas básicas e filtragem
├── condicional.sql               # Uso de estruturas condicionais (CASE, WHERE, etc.)
├── agregacao.sql                 # Operações de agregação (SUM, AVG, COUNT, etc.)
├── consultas_avancadas.sql       # Consultas mais complexas e refinadas
├── multiplas_tabelas.sql         # JOINs e operações envolvendo múltiplas tabelas
└── manipulacao.sql               # Rotinas e scripts de manipulação diversos
```

## 🛠 Tecnologias Utilizadas
- **SQL** — linguagem utilizada para manipulação de dados, consultas, filtragem, agregação e junção de tabelas.
- **Banco de dados relacional** — ambiente em que os scripts são executados (MySQL, PostgreSQL, SQLite, etc.; ajustar conforme o seu uso).

## 🚀 Como Executar
1. **Clonar o repositório**  
   ```bash
   git clone https://github.com/CMichelin07/Manipulacao-de-Dados-com-SQL.git
   cd Manipulacao-de-Dados-com-SQL
   ```

2. **Configurar o ambiente de SQL**  
   Crie ou abra uma base de dados no seu sistema escolhido (ex: MySQL, PostgreSQL, SQLite).

3. **Executar os scripts em sequência** (caso dependam uns dos outros):
   ```sql
   \i definicao.sql;
   \i consulta.sql;
   \i condicional.sql;
   \i agregacao.sql;
   \i consultas_avancadas.sql;
   \i multiplas_tabelas.sql;
   \i manipulacao.sql;
   ```
   Ajuste conforme a forma como seu sistema carrega scripts (por exemplo, `mysql < script.sql` ou no editor de SQL).

## 📊 O que Você Vai Aprender
- Como estruturar e definir tabelas SQL com dados fictícios.
- Como realizar consultas simples e aplicar filtros.
- Uso de **condicionais** para lógica dentro das consultas.
- Como **agregar** dados e extrair estatísticas úteis.
- Técnicas para **criar consultas complexas** de forma eficiente.
- Como combinar dados usando **JOINs** entre as tabelas.
- Ganha prática em manipulação de dados por meio de scripts SQL variados.
